import { http } from "@google-cloud/functions-framework";
import { handleDigest } from "./handlers/digest";
import { handleListSearch, handleListVideos } from "./handlers/youtube";
http("youtube-fetcher-digest", handleDigest);
http("youtube-fetcher-list-search", handleListSearch);
http("youtube-fetcher-list-videos", handleListVideos);
