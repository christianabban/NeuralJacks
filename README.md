# NeuralJacks

Static website build for GitHub Pages.

## Repository Structure

```text
.
├── index.html
├── index_doubleclick.html
├── assets/
├── .nojekyll
└── README.md
```

## Which HTML File To Use

- `index.html` is the normal GitHub Pages entry file. It looks almost empty if you open the source because the React app loads from the JavaScript and CSS files in `assets/`.
- `index_doubleclick.html` is the local preview file. Use this if you want to double-click and open the project directly from your computer.

## GitHub Pages Deployment

1. Upload these files to the root of your GitHub repository.
2. Open repository Settings > Pages.
3. Set Source to `Deploy from a branch`.
4. Select your branch, usually `main`, and folder `/root`.
5. Save and wait for GitHub Pages to publish.

GitHub Pages serves `index.html` over HTTP, so the files inside `assets/` load correctly. Do not upload `index.html` alone; keep the `assets/` folder beside it.
