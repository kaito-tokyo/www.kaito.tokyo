<script lang="ts">
	const slug = import.meta.url.split("/").slice(-2)[0];
	const wwwImg = `https://www-img.kaito.tokyo/artworks/${slug}`;
</script>

<svelte:head>
	<title>リフィグレの日2023</title>
</svelte:head>

<article>
	<h1>リフィグレの日2023</h1>
	<section class="metadata">
		<p>投稿日:<time datetime="2023-09-05">2023-09-05</time></p>
	</section>
	<section class="description">
		グレイシアと同じシリーズのリーフィアもなぞって並べてみました
	</section>
	<img
		src={`${wwwImg}/2023-09-05-leafeon-glaceon-day_01.png`}
		width="1600"
		height="1600"
		alt="リフィグレ背景付き"
	/>
	<img
		src={`${wwwImg}/2023-09-05-leafeon-glaceon-day_02.png`}
		width="1600"
		height="1600"
		alt="リーフィア単体"
	/>
	<img
		src={`${wwwImg}/2023-09-05-leafeon-glaceon-day_03.png`}
		width="1600"
		height="1600"
		alt="リーフィア単体透過"
	/>
</article>

<style>
	article {
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
