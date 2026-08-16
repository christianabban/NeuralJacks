# NeuralJacks

Static website for the NeuralJacks Hodgkin-Huxley and action-potential modelling project.

## Project Structure

- `index.html` - static entry point for the site.
- `assets/css/styles.css` - extracted page styles.
- `assets/js/app.js` - bundled application code.
- `assets/js/content-enhancements.js` - document/content enhancements that run after the app renders.
- `assets/images/` - local visualisation figures and MATLAB source.
- `assets/media/` - local video media.
- `assets/docs/` - PDFs for the project and supporting paper.
- `assets/downloads/` - downloadable MATLAB archive.

The original single-file export, `NeuralJacks.html`, has been left in the folder as a backup snapshot.

## Local Preview

Run a local static server from this folder:

```bash
python3 -m http.server 8765
```

Then open:

```text
http://127.0.0.1:8765/index.html
```

## GitHub Pages

This site can be deployed directly from the repository root. Use `index.html` as the entry point.

## Downloads

[Download matlab.zip](matlab.zip)
