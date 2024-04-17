export const prerender = true;

import { getArtwork1600URL, getMetadataURL, type OptimizedImageMetadata } from "$lib/newt/images";
import { type ArtworkArticle, newtClient } from "$lib/server/newt";
import type { PageServerLoad } from "./$types";

export const load = (async ({ params }) => {
	const article = await newtClient.getFirstContent<ArtworkArticle>({
		appUid: "artworks",
		modelUid: "article",
		query: {
			slug: params.slug,
			select: ["_id", "title", "slug", "images", "publishedAt", "description"]
		}
	});
	if (!article) {
		throw new Error("Article is missing!");
	}

	const { images } = article;
	if (!images) {
		throw new Error("Images are missing!");
	}

	const artwork1600WebpMetadataList = await Promise.all(images.map(async ({ src }) => {
	    const artwork1600WebpURL = getArtwork1600URL(src, ".webp");
	    const artwork1600WebpMetadataURL = getMetadataURL(artwork1600WebpURL);
	    console.log(artwork1600WebpMetadataURL);
	    const response = await fetch(artwork1600WebpMetadataURL);
	    if (!response.ok) {
	        throw new Error("Metadata file is missing!");
	    }
	    const json = await response.json() as OptimizedImageMetadata;
	    return json;
	}))

	return {
		article,
		artwork1600WebpMetadataList,
	};
}) satisfies PageServerLoad;
