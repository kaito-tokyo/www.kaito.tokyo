import { http } from "@google-cloud/functions-framework";
import { handleDigest } from "./handlers/digest.js";
import { handleListSearch, handleSaveListVideos, handleSplitListVideos } from "./handlers/youtube.js";

http("youtube-fetcher-digest", handleDigest);
http("youtube-fetcher-list-search", handleListSearch);
http("youtube-fetcher-save-list-videos", handleSaveListVideos);
http("youtube-fetcher-split-list-videos", handleSplitListVideos);
