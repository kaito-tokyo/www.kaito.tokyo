import express from "express";

import { handleDigest } from "./handlers/digest.js";
import { handleSaveSearchList, handleSplitSearchList } from "./handlers/list-search.js";
import {
	handleComposeVideoList,
	handleGenerateVideoListQueries,
	handleSaveVideoList,
	handleSplitVideoList
} from "./handlers/list-videos.js";
import {
	handleSavePlaylistItemsList,
	handleComposePlaylistItemsList
} from "./handlers/list-playlist-items.js";

const app = express();

app.post("/youtube-fetcher-digest", handleDigest);

app.get("/youtube-fetcher-save-search-list", handleSaveSearchList);
app.get("/youtube-fetcher-split-search-list", handleSplitSearchList);

app.get("/youtube-fetcher-generate-video-list-queries", handleGenerateVideoListQueries);
app.post("/youtube-fetcher-save-video-list", handleSaveVideoList);
app.get("/youtube-fetcher-compose-video-list", handleComposeVideoList);
app.get("/youtube-fetcher-split-video-list", handleSplitVideoList);

app.get("/youtube-fetcher-save-playlist-items-list", handleSavePlaylistItemsList);
app.get("/youtube-fetcher-compose-playlist-items-list", handleComposePlaylistItemsList);

const port = parseInt(process.env["PORT"] ?? "8080", 10);
app.listen(port, () => {
  console.log(`Listening on port ${port}`);
});
