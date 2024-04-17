<script lang="ts">
	import { error } from "@sveltejs/kit";

	import type { PageData } from "./$types";

	import { formatPublishedAt, getArtwork1600URL, getMetadataURL } from "$lib/newt/images";

	export let data: PageData;

	if (!data.article) {
		error(404);
	}

	const { article, artwork1600WebpMetadataList } = data;
</script>

<svelte:head>
	<title>{article.title}</title>
	<meta name="description" content={`${article.title}: ${article.description}`} />
</svelte:head>

<section>
	<article>
		<h1>{article.title}</h1>
		<section class="metadata">
			<p>投稿日：{formatPublishedAt(article.publishedAt)}</p>
		</section>
		<div>{@html article.description}</div>
		{#each article.images as image, index (image._id)}
			{@const metadata = artwork1600WebpMetadataList[index]}
			<img
				src={getArtwork1600URL(image.src, ".webp")}
				width={metadata.width}
				height={metadata.height}
				alt={`${article.title} ${index}`}
			/>
		{/each}
	</article>
</section>

<style>
	section {
		background: hsl(none none 98%);
		border-radius: 20px;
		padding: 10px;
	}

	article .metadata {
		text-align: right;
	}

	article img {
		width: 100%;
		height: 100%;
		object-fit: contain;
	}
</style>
