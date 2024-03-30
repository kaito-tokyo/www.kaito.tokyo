import { http } from "@google-cloud/functions-framework";

import {
	handleDigest,
	handleSaveSearchList,
	handleSplitSearchList,
	handleGenerateVideoListQueries,
	handleSaveVideoList,
	handleSplitVideoList,
	handleComposeVideoList,
    handleSavePlaylistItemsList
} from "www.kaito.tokyo-youtube-fetcher";

import { handleOptimizeImage, handleUploadObjectToCdn } from "www.kaito.tokyo-newt-storage";

http("youtube-fetcher-digest", handleDigest);

http("youtube-fetcher-save-search-list", handleSaveSearchList);
http("youtube-fetcher-split-search-list", handleSplitSearchList);

http("youtube-fetcher-generate-video-list-queries", handleGenerateVideoListQueries);
http("youtube-fetcher-save-video-list", handleSaveVideoList);
http("youtube-fetcher-split-video-list", handleSplitVideoList);
http("youtube-fetcher-compose-video-list", handleComposeVideoList);

http("youtube-fetcher-save-playlist-items-list", handleSavePlaylistItemsList);

http("newt-storage-optimize-image", handleOptimizeImage);
http("newt-storage-upload-object-to-cdn", handleUploadObjectToCdn);
