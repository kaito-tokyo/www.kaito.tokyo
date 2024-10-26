export const prerender = true;

import { listArtworks } from "$lib/artworks/artworks.js";

import type { PageServerLoad } from "./$types";

export const load = (async () => {
	const artworks = await listArtworks();
	return {
		artworks
	};
}) satisfies PageServerLoad;
