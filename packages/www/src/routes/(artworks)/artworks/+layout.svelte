<script lang="ts">
	import "./style.css";
</script>

<article>
	<slot></slot>
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
