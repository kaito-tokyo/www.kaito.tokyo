import { GoogleAuth } from "google-auth-library";
import { Storage } from "@google-cloud/storage";
import { google } from "googleapis";

export const youtubeService = google.youtube("v3");

export const googleAuth = new GoogleAuth({
	scopes: ["https://www.googleapis.com/auth/youtube.readonly"]
});

export const storage = new Storage();
