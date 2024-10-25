import { readdir } from "node:fs/promises";

const ARTWORK_DIR_PREFIX = "src/routes/artworks";

export async function listArtworkSlugs() {
	const slugs = await readdir(ARTWORK_DIR_PREFIX);
	return slugs.filter((slug) => slug.startsWith("2"));
}

export async function listArtworks() {
	const slugs = await listArtworkSlugs();
	return await Promise.all(
		slugs.map(async (slug) => {
			const children = await readdir(`${ARTWORK_DIR_PREFIX}/${slug}`);
			const images = children.filter((file) => /^2.*\.png$/.test(file));
			return {
				slug,
				images
			};
		})
	);
}
