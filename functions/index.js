const {
  // onDocumentWritten,
  onDocumentCreated,
  // onDocumentUpdated,
  // onDocumentDeleted,
  // Change,
  // FirestoreEvent
} = require("firebase-functions/v2/firestore");
const {
  beforeUserCreated,
  HttpsError,
} = require("firebase-functions/v2/identity");
const {onObjectFinalized} = require("firebase-functions/v2/storage");
const admin = require("firebase-admin");
const logger = require("firebase-functions/logger");
const {getStorage} = require("firebase-admin/storage");
// const path = require("path");

// library for image resizing
// const sharp = require("sharp");

const {v4: uuidv4} = require("uuid");
const crypto = require("crypto");

admin.initializeApp();

const userRef = "users/{user}";

const keyUploads = "uploads";
const keyIncreaseDownload = "increaseDownload";

exports.createUserSecondGen = onDocumentCreated(userRef, async (event) => {
  // check first of the counter collection exit
  const countersColRef = admin.firestore().collection("counters");
  const countersSnapshot = await countersColRef.limit(1).get();

  if (countersSnapshot.empty) {
    await countersColRef.doc("users").create({
      total: 1,
    });
  } else {
    const usersSnap = await countersColRef.doc("users").get();
    const usersData = usersSnap.data();

    await countersColRef.doc("users").update({
      total: admin.firestore.FieldValue.increment(usersData.total),
    });
  }
});


exports.increaseDownload = onDocumentCreated(keyIncreaseDownload,
    async (change) => {
      const uploadsColRef = admin.firestore().collection(keyUploads);
      const docId = change.data().id;

      await uploadsColRef.doc(docId).update({
        downloads: admin.firestore.FieldValue.increment(1),
      });
    });


exports.setupNewUserSecondGen = beforeUserCreated(async (event) => {
  const user = event.data;
  if (!user.email.includes("@spu.ac.za")) {
    throw new HttpsError(
        "invalid-argument", "Unauthorized email");
  } else {
    user.emailVerified = true;
    const additionalUserInfo = event.additionalUserInfo;
    await admin.firestore().collection("users").doc(user.uid).set({
      // classId: additionalUserInfo.profile["officeLocation"],
      // type: additionalUserInfo.profile["jobTitle"],
      names: additionalUserInfo.profile["givenName"],
      surname: additionalUserInfo.profile["surname"],
    });
  }
});

// Function triggered by file upload to Firebase Storage
// todo: determine type on upload to prevent wrong data upload
// todo: prevent duplicate
exports.onFileUploadSecondGen = onObjectFinalized({cpu: 2}, async (event) => {
  const fileBucket = event.data.bucket; // Storage bucket containing the file.
  const filePath = event.data.name; // File path in the bucket.
  // const contentType = event.data.contentType; // File content type.
  const size = parseInt(event.data.size);

  const db = admin.firestore();
  // Download file into memory from bucket.
  const bucket = getStorage().bucket(fileBucket);
  const file = bucket.file(filePath);

  logger.log(`File uploaded: ${filePath}`);
  // logger.log(`Content type: ${contentType}`);
  logger.log(`Size: ${size} bytes`);
  // logger.log(`Uploaded by UID: ${uid}`);
  // logger.log(`Object: ${object}`);

  // Generate a hash of the file content
  // Download file contents
  const [fileContents] = await file.download();

  // Generate a hash of the file content
  const hash = crypto.createHash("sha256").
      update(fileContents).digest("hex");

  // Generate a hash of the file content
  // const hash = crypto.createHash("sha256").
  //     update(Buffer.from(object, "base64")).digest("hex");

  // Check Firestore for existing file hash
  const hashRef = db.collection("fileHashes").doc(hash);
  const hashDoc = await hashRef.get();
  logger.log(`hash? ${hash}`);
  logger.log(`file exist? ${hashDoc.exists}`);

  if (hashDoc.exists) {
    // Delete the duplicate file
    await file.delete();
  } else {
    if (filePath.split("/")[0] == "uploads") {
      const uid = filePath.split("/")[1]; // Get the UID of the user

      // todo make it private with recurring update
      // Generate a signed URL for the file
      // const [url] = await file.getSignedUrl({
      //   action: "read",
      //   expires: "03-17-2025", // Set the expiration date as needed
      // });


      // Make the file publicly accessible
      await file.makePublic();

      // Get the public URL
      const url = `https://storage.googleapis.com/${bucket.name}/${filePath}`;

      logger.log(`Download URL: ${url}`);

      const newUuid = uuidv4();
      // Save metadata including download URL to Firestore
      const metadata = {
        size: formatBytes(size),
        url: url,
        uid: uid,
        name: filePath.split("/")[2],
        uploaded: admin.firestore.FieldValue.serverTimestamp(),
      };

      await db.collection("uploads").doc(newUuid).create(metadata);
      await db.collection("fileHashes").doc(hash).create({
        docId: newUuid,
      });
    }
  }
  // return null;
});

/**
 * Converts bytes to a human-readable format.
 *
 * @param {number} bytes - The number of bytes to convert.
 * @return {string} The converted human-readable size.
 */
function formatBytes(bytes) {
  const k = 1024;
  if (bytes < k) return "1 KB";
  const sizes = ["Bytes", "KB", "MB", "GB", "TB", "PB", "EB", "ZB", "YB"];
  const i = Math.floor(Math.log(bytes) / Math.log(k));
  return parseFloat((bytes / Math.pow(k, i)).toFixed(2)) + " " + sizes[i];
}
