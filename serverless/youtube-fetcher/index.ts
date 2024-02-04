import { http } from "@google-cloud/functions-framework";
import { type GaxiosResponse } from "gaxios";
import { google, youtube_v3 } from "googleapis";

const service = google.youtube("v3");

function listChannels(params: youtube_v3.Params$Resource$Channels$List): Promise<GaxiosResponse<youtube_v3.Schema$ChannelListResponse> | null | undefined> {
	return new Promise((resolve, reject) => {
		service.channels.list(params, (err, response) => {
			if (err) {
				reject(err);
			} else {
				resolve(response);
			}
		})
	});
}

http("youtube-video-fetcher", async (_, res) => {
	const response = await listChannels({
		part: ["snippet"],
		forUsername: "GoogleDevelopers",
	})
	res.send(response?.data);
});
