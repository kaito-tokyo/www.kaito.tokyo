import { http } from "@google-cloud/functions-framework";
import { handleDigest } from "./handlers/digest.js";
import { handleListSearch } from "./handlers/list-search.js";
import {
	handleSaveListVideos,
	handleSplitListVideos,
	handleGenerateListVideosQueries
} from "./handlers/list-videos.js"

http("youtube-fetcher-digest", handleDigest);
http("youtube-fetcher-list-search", handleListSearch);
http("youtube-fetcher-generate-list-videos-queries", handleGenerateListVideosQueries);
http("youtube-fetcher-save-list-videos", handleSaveListVideos);
http("youtube-fetcher-split-list-videos", handleSplitListVideos);
