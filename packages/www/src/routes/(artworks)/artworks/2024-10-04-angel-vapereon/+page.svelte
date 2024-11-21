<script lang="ts">
	import { dev } from "$app/environment"
	const slug = import.meta.url.split("/").slice(-2)[0];
	let wwwImg: string;
	if (dev) {
		wwwImg = `.`;
	} else {
		wwwImg = `https://www-img.kaito.tokyo/artworks/${slug}`;
	}

	import image01 from "./2024-10-04-angel-vapereon_01.png";
</script>

<svelte:head>
	<title>ポケモン天使化 シャワーズ</title>
</svelte:head>

<article>
	<h1>ポケモン天使化 シャワーズ</h1>
	<section class="metadata">
		<p>投稿日:<time datetime="2024-10-04">2024-10-04</time></p>
	</section>
	<section class="description">
		ポケモン天使化の企画に参加しました
	</section>
	<img
		src={image01}
		width="1600"
		height="1600"
		alt="天使シャワーズ"
	/>
</article>
