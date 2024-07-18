const functions = require("firebase-functions");
const admin = require("firebase-admin");
const logger = require("firebase-functions/logger");

admin.initializeApp();

const newUserRef = "users/{user}";

exports.createUser = functions.firestore
    .document(newUserRef)
    .onCreate(async (change, _) => await updateCounter(change));
/**
 * update Counters.
 * @param {functions.firestore.QueryDocumentSnapshot} change Document Created.
 */
async function updateCounter(change) {
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
}

exports.setupNewUser = functions.auth.user().
    beforeCreate(async (user, context) => {
      if (!user.email || user.email.indexOf("@spu.ac.za") === -1) {
        return functions.logger.log(
            "invalid-argument", "Unauthorized email " + user.email);
      } else {
        user.emailVerified = true;
        // const additionalUserInfo = context.additionalUserInfo;
        // await admin.firestore().collection("users").doc(user.uid).set({
        //   classId: additionalUserInfo.profile["officeLocation"],
        //   type: additionalUserInfo.profile["jobTitle"],
        //   names: additionalUserInfo.profile["givenName"],
        //   surname: additionalUserInfo.profile["surname"],
        // });
      }
    });

// Function triggered by file upload to Firebase Storage
exports.onFileUpload = functions.storage.object().
    onFinalize(async (object) => {
      const filePath = object.name;
      const contentType = object.contentType;
      const size = object.size;

      logger.log(`File uploaded: ${filePath}`);
      logger.log(`Content type: ${contentType}`);
      logger.log(`Size: ${size} bytes`);
      // logger.log(`Uploaded by UID: ${uid}`);
      logger.log(`Object: ${object}`);

      if (filePath.split("/")[0] == "uploads") {
        const uid = filePath.split("/")[1]; // Get the UID of the user
        const bucket = admin.storage().bucket(object.bucket);
        const file = bucket.file(filePath);

        // todo make it private with recurring update
        // Generate a signed URL for the file
        // const [url] = await file.getSignedUrl({
        //   action: 'read',
        //   expires: '03-17-2025', // Set the expiration date as needed
        // });


        // Make the file publicly accessible
        await file.makePublic();

        // Get the public URL
        const url = `https://storage.googleapis.com/${bucket.name}/${filePath}`;

        logger.log(`Download URL: ${url}`);

        // Save metadata including download URL to Firestore
        const metadata = {
          size: size,
          downloadURL: url,
          uid: uid, // Add UID to the metadata
          timestamp: admin.firestore.FieldValue.serverTimestamp(),
        };

        const db = admin.firestore();
        await db.collection("uploads").add(metadata);
      }
      return null;
    });
