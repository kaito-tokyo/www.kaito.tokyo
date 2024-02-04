import { http } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { google, youtube_v3 } from "googleapis";
import { GoogleAuth } from "google-auth-library";
import { type BodyResponseCallback } from "googleapis-common";

const service = google.youtube("v3");

function listSearch(
	params: youtube_v3.Params$Resource$Search$List
): Promise<GaxiosResponse<youtube_v3.Schema$SearchListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		service.search.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		});
	});
}

http("youtube-video-fetcher", async (_, res) => {
	const response = await listSearch({
		auth: new GoogleAuth({
			scopes: ["https://www.googleapis.com/auth/youtube.readonly"]
		}),
		part: ["snippet"],
		forMine: true
	});
	res.send(response?.data);
});
