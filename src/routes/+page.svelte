<script lang="ts">
	import { formatInTimeZone } from "date-fns-tz";
	import { Image } from "@unpic/svelte";

	import type { PageData } from './$types';
	export let data: PageData;

	function formatDate(dateString: string): string {
		return formatInTimeZone(new Date(dateString), "Asia/Tokyo", "yyyy-MM-dd")
	}
</script>

<svelte:head>
	<title>Home</title>
	<meta name="description" content="Svelte demo app" />
    <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Zen+Kaku+Gothic+New:wght@300">
</svelte:head>

<main>
	<section id="illustration-grid">
		{#each data.articles as article (article._id)}
			<a href={`illustrations/${article.slug}`}>
				<article>
					<Image
						src={article.images[0].src}
						width={200}
						height={200}
					/>
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
		column-gap: 30px;
		grid-template-columns: 210px 210px 210px;
	}

	#illustration-grid article {
		font-family: 'Zen Kaku Gothic New', serif;
		padding: 5px;
		background: hsl(none none 95%);
		box-shadow: 10px 5px 5px red;
		width: 200px;
		height: 240px;
		transition: transform 0.1s;
	}

	#illustration-grid article:hover {
		transform: scale(1.05);
	}

	#illustration-grid p {
		margin: 0;
		padding: 0;
		font-size: 15px;
		line-height: 17px;
	}

	section {
		display: flex;
		flex-direction: column;
		justify-content: center;
		align-items: center;
		flex: 0.6;
	}

	h1 {
		width: 100%;
	}

	.welcome {
		display: block;
		position: relative;
		width: 100%;
		height: 0;
		padding: 0 0 calc(100% * 495 / 2048) 0;
	}

	.welcome img {
		position: absolute;
		width: 100%;
		height: 100%;
		top: 0;
		display: block;
	}
</style>
