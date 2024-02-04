import { http } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { google, youtube_v3 } from "googleapis";
import { GoogleAuth } from "google-auth-library";
import { type BodyResponseCallback } from "googleapis-common";

const service = google.youtube("v3");

function promisifyYouTubeDataAPI<Params, Response>(
	func: (params: Params, callback: BodyResponseCallback<Response>) => void
): (params: Params) => Promise<GaxiosResponse<Response> | null | undefined> {
	return (params) =>
		new Promise((resolve, reject) => {
			func(params, (err, response) => {
				if (err) {
					reject(err);
				} else {
					resolve(response);
				}
			});
		});
}

const listSearch = promisifyYouTubeDataAPI<
	youtube_v3.Params$Resource$Search$List,
	youtube_v3.Schema$SearchListResponse
>(service.search.list);

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
