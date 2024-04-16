<script lang="ts">
	import { base } from "$app/paths";

	import type { PageData } from "./$types";

	import { getThumbnail400URL, formatPublishedAt } from "$lib/newt/images";

	export let data: PageData;
</script>

<svelte:head>
	<title>Umireon's Artworks - www.kaito.tokyo</title>
	<meta name="description" content="The artworks that umireon have made." />
</svelte:head>

<main>
	<section id="artwork-grid" class="grid">
		{#each data.articles as article (article._id)}
			<a href={`${base}/artworks/${article.slug}`}>
				<article>
					<img
						src={getThumbnail400URL(article.images[0].src, ".webp")}
						alt={article.title}
						width={200}
						height={200}
					/>
					<p class="title">{article.title}</p>
					<p class="publishedAt">{formatPublishedAt(article.publishedAt)}</p>
				</article>
			</a>
		{/each}
	</section>
</main>

<style>
	.grid {
		display: grid;
		column-gap: 20px;
		row-gap: 20px;
		grid-template-columns: 1fr 1fr;
		padding: 20px 25px 0 25px;
	}

	.grid img {
		width: 100%;
		object-fit: cover;
	}

	@media (min-width: 720px) {
		.grid {
			grid-template-columns: 1fr 1fr 1fr;
		}
	}

	.grid article {
		padding: 1vw;
		background: hsl(none none 98%);
		box-shadow: 10px 10px 10px hsl(none none 40%);
		transition: transform 0.1s;
		border-radius: 10px;
	}

	.grid article:hover {
		transform: scale(1.05);
	}

	.grid p {
		margin: 0;
		padding: 0;
	}
</style>
