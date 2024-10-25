<script lang="ts">
	import { base } from "$app/paths";

	import type { PageData } from "./$types";

	export let data: PageData;
</script>

<svelte:head>
	<title>うみれおんのイラスト - www.kaito.tokyo</title>
	<meta name="description" content="うみれおんが描いたイラスト" />
</svelte:head>

<main>
	<section id="artwork-grid" class="grid">
		{#each data.artworks as { slug } (slug)}
			<a href={`${base}/artworks/${slug}`}>
				<article>
					<img
						src={`https://www-img.kaito.tokyo/artworks/${slug}/thumbnail400.webp`}
						width={200}
						height={200}
					/>
					<p class="title">{slug}</p>
					<!--p class="publishedAt">{formatPublishedAt(article.publishedAt)}</p-->
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
