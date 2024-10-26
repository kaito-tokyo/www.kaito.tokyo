<script lang="ts">
    const slug = import.meta.url.split("/").slice(-2)[0]
	const wwwImg = `https://www-img.kaito.tokyo/artworks/${slug}`;
</script>

<svelte:head>
	<title>2番目に描いた絵</title>
</svelte:head>

<article>
	<h1>2番目に描いた絵</h1>
	<section class="metadata">
		<p>投稿日:<time datetime="2023-05-12">2023-05-12</time></p>
	</section>
	<section class="description">
		前の絵を元になぞり直しただけ、ちょっとうまくなった
	</section>
	<img
		src={`${wwwImg}/2023-05-12-my-second-painting_01.png`}
		width="1600"
		height="1600"
		alt="ブラッキー"
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
