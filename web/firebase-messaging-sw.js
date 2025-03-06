importScripts("https://www.gstatic.com/firebasejs/10.0.0/firebase-app-compat.js");
importScripts("https://www.gstatic.com/firebasejs/10.0.0/firebase-messaging-compat.js");

firebase.initializeApp({
  apiKey: "AIzaSyBJoGd-ICamIoijQPOdm4nBwQErRqAf-1A",
  authDomain: "smile-chat-e4dd0.firebaseapp.com",
  projectId: "smile-chat-e4dd0",
  storageBucket: "smile-chat-e4dd0.firebasestorage.app",
  messagingSenderId: "1064039747805",
  appId: "1:1064039747805:web:88cd078f225e2360c34b34",
});

const messaging = firebase.messaging();

messaging.onBackgroundMessage((payload) => {
  console.log("Received background message ", payload);
  self.registration.showNotification(payload.notification.title, {
    body: payload.notification.body,
    icon: "/icons/icon-192x192.png",
  });
});
