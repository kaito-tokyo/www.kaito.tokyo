import { http } from "@google-cloud/functions-framework";

http("youtube-video-fetcher", (_, res) => {
    res.send("OK");
});
