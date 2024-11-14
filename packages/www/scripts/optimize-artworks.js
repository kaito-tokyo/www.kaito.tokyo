import { readdir } from "node:fs/promises";

import sharp from "sharp";

const ARTWORK_DIR_PREFIX = "src/routes/(artworks)/artworks";

async function listArtworkSlugs() {
	const slugs = await readdir(ARTWORK_DIR_PREFIX);
	return slugs.filter((slug) => slug.startsWith("2"));
}

async function listArtworks() {
	const slugs = await listArtworkSlugs();
	return await Promise.all(
		slugs.map(async (slug) => {
			const children = await readdir(`${ARTWORK_DIR_PREFIX}/${slug}`);
			const images = children.filter((file) => /\.png$/.test(file));
			return {
				slug,
				images
			};
		})
	);
}

async function main() {
	const artworks = await listArtworks();
	for (const { slug, images } of artworks) {
		const [firstImage] = images;
		if (firstImage) {
			const artworkDir = `${ARTWORK_DIR_PREFIX}/${slug}`;
			const image = sharp(`${artworkDir}/${firstImage}`);
			image.resize(400, 400, { fit: "contain" }).toFile(`${artworkDir}/thumbnail400.webp`);
		}
	}
}

main();
