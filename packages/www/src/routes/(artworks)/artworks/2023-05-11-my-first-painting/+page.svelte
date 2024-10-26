<script lang="ts">
    const slug = import.meta.url.split("/").slice(-2)[0]
	const wwwImg = `https://www-img.kaito.tokyo/artworks/${slug}`;
</script>

<svelte:head>
	<title>初めて描いた絵</title>
</svelte:head>

<h1>初めて描いた絵</h1>
<section class="metadata">
	<p>投稿日:<time datetime="2023-05-11">2023-05-11</time></p>
</section>
<section class="description">
	ポケモンセンターオンラインのブラッキーのアイコンをなぞってみましたが、あまり上手にできませんでした。
</section>
<img
	src={`${wwwImg}/2023-05-11-my-first-painting_01.png`}
	width="1600"
	height="1600"
	alt="ブラッキー"
/>
