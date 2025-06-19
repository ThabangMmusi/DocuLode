**Objective:**

Create a high-quality, robust Flutter package named `pdf_struct_to_markdown` that converts text-based PDF documents into well-structured Markdown. The key differentiator for this package must be its ability to perform layout analysis to infer semantic structure (paragraphs, headings, lists, text styling) from the PDF, similar to how a rendering engine understands a PDF for display, but outputting Markdown instead.

**Core Requirements:**

1.  **Deep PDF Parsing (No High-Level Rendering SDKs like Syncfusion for the core logic):**

*   The package must parse PDF files to extract detailed information about their content elements.

*   **Text Elements:** For each piece of text, extract:

*   Content (the characters).

*   Precise X, Y coordinates and bounding box.

*   Font information: name (e.g., "Arial-BoldMT", "TimesNewRoman-Italic"), size, weight (if discernible from font name or properties), and italic status.

*   **Image Elements:**

*   Extract raw image data.

*   Identify image format if possible (JPEG, PNG, etc.).

*   Store bounding box/coordinates.

2.  **Layout Analysis & Semantic Structure Inference:**

*   This is the most critical part. Implement algorithms to analyze the extracted elements and infer the document's logical structure:

*   **Reading Order:** Determine the correct sequence of text blocks, especially for multi-column layouts.

*   **Paragraph Aggregation:** Group lines of text into coherent paragraphs based on proximity, consistent font styling, and line spacing. A simple newline split is insufficient; distinguish between line wraps within a paragraph and actual paragraph breaks.

*   **Heading Detection (H1-H6):** Identify headings by analyzing font size (significantly larger than body text), font weight (bold), distinct styling (e.g., all caps), and spacing above/below. Assign appropriate heading levels.

*   **List Detection:** Recognize ordered (e.g., "1.", "a.") and unordered (e.g., "-", "*", "•") lists. Identify list items, their content, and attempt to handle basic indentation for nested lists if feasible.

*   **Text Style Inference (Bold/Italic):** Infer **bold** and *italic* styling from font names (e.g., "Helvetica-Bold", "Times-Italic") or other font properties available from the parser.

*   **Image Handling:** Save extracted images to a specified output directory (or a temporary one). The Markdown should reference these saved images.

3.  **Intermediate Data Representation:**

*   Define a clear Dart data model (e.g., a list of `ContentBlock` objects) to hold the structured content *after* layout analysis. Each `ContentBlock` should represent a semantic element (e.g., paragraph, heading, list item, image) and store its data (text, image path, alt text) and attributes (heading level).

4.  **Markdown Generation:**

*   Convert the structured intermediate representation into clean, standard Markdown.

*   Ensure correct Markdown syntax for:

*   Headings (`# H1`, `## H2`, etc.)

*   Paragraphs (with appropriate line breaks between them).

*   Unordered and ordered lists.

*   **Bold** and *italic* text.

*   Images (`!alt text`).

**Technical Specifications for the Flutter Package:**

*   **Language:** Dart (for Flutter compatibility).

*   **PDF Parsing Strategy:**

*   Prioritize pure-Dart PDF parsing libraries if they can provide the detailed element information (text with coordinates, font details) required for layout analysis.

*   If pure-Dart options are insufficient, use Dart FFI to interface with a robust, permissively licensed native PDF parsing library (e.g., MuPDF, PDFium). **Avoid relying on high-level commercial SDKs for the core parsing and rendering logic.**

*   **API Design:**

*   Provide a simple, asynchronous top-level function:

```dart

Future<String> convertPdfToMarkdown(

String pdfPath,

{String? imageOutputDir} // Optional: directory to save extracted images

);

```

*   The package should be self-contained as much as possible.

*   **Error Handling:** Implement robust error handling for invalid PDF files, parsing errors, etc.

*   **No OCR:** This version should focus on text-based PDFs. Scanned PDFs are out of scope.

**Deliverables:**

1.  The complete source code for the Flutter package `pdf_struct_to_markdown`.

2.  A `README.md` file with clear installation and usage instructions.

3.  At least one example Flutter application demonstrating the package's usage.

4.  A brief explanation of the heuristics and algorithms used for layout analysis and structure inference.

**Evaluation Criteria:**

*   Accuracy of Markdown structure relative to the visual layout of common PDF documents.

*   Correct identification of headings, paragraphs, lists, and basic text styling.

*   Robustness and error handling.

*   Clarity and quality of the Dart code.