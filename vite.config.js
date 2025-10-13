// vite.config.js
import { defineConfig } from "vite"
import tailwindcss from "@tailwindcss/vite"
import injectHTML from "vite-plugin-html-inject"

export default defineConfig({
	root: "frontend",
	base: "./",
	plugins: [tailwindcss(), injectHTML()],
	build: {
		outDir: "../dist",
		emptyOutDir: true,
		rollupOptions: {
			output: {
				// fixed name for the main JavaScript bundle
				entryFileNames: "assets/app.js",
				// fixed name for dynamic chunks
				chunkFileNames: "assets/[name].js",
				// fixed name for emitted CSS and other assets
				assetFileNames: (assetInfo) => {
					if (
						assetInfo.names[0] &&
						assetInfo.names[0].endsWith(".css")
					) {
						return "assets/app.css" // single fixed CSS filename
					}
					return "assets/[name].[ext]" // images, fonts, etc.
				},
			},
		},
	},
})
