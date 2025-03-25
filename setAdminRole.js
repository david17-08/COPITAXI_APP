const admin = require("firebase-admin");
const serviceAccount = require("./serviceAccountKey.json"); 

// Inicializa Firebase Admin SDK
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount)
  });  

const auth = admin.auth();

const adminUID = "sF8YmLnwtRXrjTJsgonZzqaZtkZ2"; 

async function setAdminRole() {
  try {
    await auth.setCustomUserClaims(adminUID, { admin: true });
    console.log(`✅ Usuario ${adminUID} ahora es administrador.`);
  } catch (error) {
    console.error("❌ Error asignando rol de administrador:", error);
  }
}

setAdminRole();
