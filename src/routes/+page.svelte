<script lang="ts">
	import { formatInTimeZone } from "date-fns-tz";
	import { Image } from "@unpic/svelte";

	import type { PageData } from "./$types";
	export let data: PageData;

	function formatDate(dateString: string): string {
		return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd");
	}
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
	<link
		rel="stylesheet"
		href="https://fonts.googleapis.com/css2?family=Zen+Kaku+Gothic+New:wght@300"
	/>
</svelte:head>

<main>
	<section id="illustration-grid">
		{#each data.articles as article (article._id)}
			<a href={`illustrations/${article.slug}`}>
				<article>
					<Image src={article.images[0].src} width={500} height={500} />
					<p class="title">{article.title}</p>
					<p class="publishedAt">{formatDate(article.publishedAt)}</p>
				</article>
			</a>
		{/each}
	</section>
</main>

<style>
	#illustration-grid {
		display: grid;
		column-gap: 20px;
		row-gap: 20px;
		grid-template-columns: 1fr 1fr;
	}

	@media (min-width: 720px) {
		#illustration-grid {
			grid-template-columns: 1fr 1fr 1fr;
		}
	}

	#illustration-grid article {
		font-family: "Zen Kaku Gothic New", serif;
		padding: 1vw;
		background: hsl(none none 98%);
		box-shadow: 10px 10px 10px hsl(none none 40%);
		transition: transform 0.1s;
		border-radius: 10px;
	}

	#illustration-grid article:hover {
		transform: scale(1.05);
	}

	#illustration-grid p {
		margin: 0;
		padding: 0;
	}
</style>
