abstract class DBKeys {
  DBKeys._();

  static const keyPlans = _Keys.keyPlans;
  static const keyClients = _Keys.keyClients;
  static const keyClientId = _Keys.keyClientId;
  static const keyBusiness = _Keys.keyBusiness;
  static const keyMore = _Keys.keyMore;
  static const keyContacts = _Keys.keyContacts;

  static const keyVerifiedCounters = _Keys.keyVerifiedCounters;
  static const keyCounters = _Keys.keyCounters;
  static const keyTotal = _Keys.keyTotal;

  // static const keyLastReceiptID = _Keys.keyLastReceiptID;
  // static const keyReceiptID = _Keys.keyReceiptID;
  static const keyReason = _Keys.keyReason;
  static const keyRejects = _Keys.keyRejects;
  static const keyApproved = _Keys.keyApproved;
  static const keyStatus = _Keys.keyStatus;
  static const keyPlanId = _Keys.keyPlanId;
  static const keyDateCreated = _Keys.keyDateCreated;
  static const keyDueDate = _Keys.keyDueDate;

  static const keyActive = _Keys.keyActive;
  static const keyInactive = _Keys.keyInactive;
  static const keyUse = _Keys.keyUse;
  static const keyUsers = _Keys.keyUsers;
  static const keyOwners = _Keys.keyOwners;
  static const keyIsOwner = _Keys.keyIsOwner;

  static const keyAccountHolder = _Keys.keyAccountHolder;
  static const keySpouse = _Keys.keySpouse;
  static const keyAccount = _Keys.keyAccount;
  static const keyAmount = _Keys.keyAmount;
  static const keyAmountDue = _Keys.keyAmountDue;
  static const keyCash = _Keys.keyCash;
  static const keyCard = _Keys.keyCard;
  static const keyPayments = _Keys.keyPayments;

  static const keyNo = _Keys.keyNo;
  static const keyId = _Keys.keyId;
  static const keyName = _Keys.keyName;
  static const keyType = _Keys.keyType;
  static const keyCategory = _Keys.keyCategory;
  static const keyTrial = _Keys.keyTrial;
  static const keyPremium = _Keys.keyPremium;
  static const keyJoining = _Keys.keyJoining;

  static const keyRestrictions = _Keys.keyRestrictions;
  static const keyToInsure = _Keys.keyToInsure;
  static const keyDependents = _Keys.keyDependents;
  static const keyClaims = _Keys.keyClaims;

  static const keyFrom = _Keys.keyFrom;
  static const keyTo = _Keys.keyTo;

  static const keyWhole = _Keys.keyWhole;
  static const keyMain = _Keys.keyMain;
  static const keyBeneficiaries = _Keys.keyBeneficiaries;

//for newly created users(employee/owners) account
  static const keyWeakPW = _Keys.keyWeakPW;
//employee id
  static const keyEmployeeId = _Keys.keyEID;
  static const keyEmployees = _Keys.keyEmployees;
  //branch id
  static const keyBID = _Keys.keyBID;
  //branches
  static const keyBranches = _Keys.keyBranches;
  //organization id
  static const keyOID = _Keys.keyOID;
  //used for receipt id and role id
  static const keyRID = _Keys.keyRID;

  static const keyCellNo = _Keys.keyCellNo;
  static const keyAltCellNo = _Keys.keyAltCellNo;
  static const keyPhysicalAddress = _Keys.keyPhysicalAddress;
  static const keyEmailAddress = _Keys.keyEmailAddress;
  static const keyWebSiteAddress = _Keys.keyWebSiteAddress;

  static const keyStreet = _Keys.keyStreet;
  static const keyLocation = _Keys.keyLocation;
  static const keyCity = _Keys.keyCity;
  static const keyPostalCode = _Keys.keyPostalCode;
}

abstract class _Keys {
  static const keyPlans = 'plans';
  static const keyClients = 'clients';
  static const keyClientId = 'clientsId';
  static const keyBusiness = 'orgs';
  static const keyMore = 'more';
  static const keyContacts = 'contacts';

  static const keyVerifiedCounters = 'verifiedCounters';
  static const keyCounters = 'counters';
  static const keyTotal = 'total';

  static const keyReason = 'reason';
  static const keyStatus = 'status';
  static const keyPlanId = 'planId';
  static const keyDateCreated = 'createdAt';
  static const keyDueDate = 'dueDate';

  static const keyActive = "active";
  static const keyInactive = "inactive";
  static const keyUsers = "users";
  static const keyUse = "use";
  static const keyOwners = "owners";
  static const keyIsOwner = 'isOwner';

  static const keyAccountHolder = 'accHolder';
  static const keySpouse = 'spouse';
  static const keyAccount = 'account';
  static const keyAmountDue = 'due';
  static const keyAmount = 'amount';
  static const keyCash = 'cash';
  static const keyCard = 'card';
  static const keyPayments = 'payments';

  static const keyNo = 'no';
  static const keyId = 'id';
  static const keyName = 'name';
  static const keyType = 'type';
  static const keyCategory = 'category';
  static const keyTrial = 'trial';
  static const keyPremium = 'premium';
  static const keyJoining = 'jFee';

  static const keyClaims = "claims";
  static const keyApproved = "approved";
  static const keyRejects = "rejects";
  static const keyRestrictions = 'barriers';
  static const keyToInsure = 'toInsure';
  static const keyDependents = 'dependents';

  static const keyFrom = 'from';
  static const keyTo = 'to';

  static const keyWhole = 'whole';
  static const keyMain = 'main';
  static const keyBeneficiaries = 'payee';

  static const keyWeakPW = 'weak_pw';
  static const keyEID = 'eid';
  static const keyEmployees = "employees";
  static const keyBID = 'bid';
  static const keyBranches = 'branches';
  static const keyOID = 'oid';
  static const keyRID = 'rid';

  static const keyCellNo = 'cellNo';
  static const keyAltCellNo = 'altCellNo';
  static const keyPhysicalAddress = 'address';
  static const keyEmailAddress = 'email';
  static const keyWebSiteAddress = 'website';

  static const keyStreet = 'street';
  static const keyLocation = 'location';
  static const keyCity = 'city';
  static const keyPostalCode = 'code';
}
