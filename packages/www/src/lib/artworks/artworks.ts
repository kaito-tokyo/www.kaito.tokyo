import { readdir, readFile } from "node:fs/promises";

const ARTWORK_DIR_PREFIX = "src/routes/(artworks)/artworks";

export async function listArtworkSlugs() {
	const slugs = await readdir(ARTWORK_DIR_PREFIX);
	return slugs.filter((slug) => slug.startsWith("2"));
}

export async function listArtworks() {
	const slugs = await listArtworkSlugs();
	return await Promise.all(
		slugs.toReversed().map(async (slug) => {
			const children = await readdir(`${ARTWORK_DIR_PREFIX}/${slug}`);
			const images = children.filter((file) => /^2.*\.png$/.test(file));
			const pageText = await readFile(`${ARTWORK_DIR_PREFIX}/${slug}/+page.svelte`);
			const [, title] = pageText.toString().match(/<title>([^<]*)<\/title>/) ?? [];
			const [, publishedAt] = pageText.toString().match(/<time datetime="([^"]*)">/) ?? [];
			return {
				slug,
				images,
				title,
				publishedAt
			};
		})
	);
}
