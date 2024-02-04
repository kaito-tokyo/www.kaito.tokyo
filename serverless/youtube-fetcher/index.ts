import { http } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { google, youtube_v3 } from "googleapis";
import { GoogleAuth, Impersonated, OAuth2Client } from "google-auth-library";

const service = google.youtube("v3");

async function getAccessTokenFromImpersonatedCredentials() {
	const googleAuth = new GoogleAuth({
		scopes: [],
	});
	const { credential } = await googleAuth.getApplicationDefault();
	const impersonatedCredentials = new Impersonated({
		sourceClient: credential,
	});
	const { token } = await impersonatedCredentials.getAccessToken();
	return token;
}

function listChannels(
	params: youtube_v3.Params$Resource$Channels$List
): Promise<GaxiosResponse<youtube_v3.Schema$ChannelListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		service.channels.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
}

http("youtube-video-fetcher", async (_, res) => {
	const response = await listChannels({
		auth: new GoogleAuth({
			scopes: ["https://www.googleapis.com/auth/youtube.readonly"],
		}),
		part: ["snippet"],
		forUsername: "GoogleDevelopers"
	});
	res.send(response?.data);
});
