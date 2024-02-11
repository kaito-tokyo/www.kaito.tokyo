import { http } from "@google-cloud/functions-framework";
import { handleDigest } from "./handlers/digest.js";
import {
	handleSaveSearchList,
	handleSplitSearchList
} from "./handlers/list-search.js";
import {
	handleComposeVideoList,
	handleGenerateVideoListQueries,
	handleSaveVideoList,
	handleSplitVideoList
} from "./handlers/list-videos.js";

http("youtube-fetcher-digest", handleDigest);

http("youtube-fetcher-save-search-list", handleSaveSearchList);
http("youtube-fetcher-split-search-list", handleSplitSearchList);

http("youtube-fetcher-generate-video-list-queries", handleGenerateVideoListQueries);
http("youtube-fetcher-save-video-list", handleSaveVideoList);
http("youtube-fetcher-split-video-list", handleSplitVideoList);
http("youtube-fetcher-compose-video-list", handleComposeVideoList);
