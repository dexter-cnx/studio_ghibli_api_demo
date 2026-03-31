# DESIGN.md: Wind Rises Studio (The Cinematic Hearth)

## 1. Design Principles
- **Cinematic Immersion:** Prioritize high-quality film posters and generous whitespace to create a "hearth-like" warmth.
- **Calm Readability:** Use serif typography for high-contrast storytelling and sans-serif for metadata to ensure legibility.
- **Soft Geometry:** Extensive use of `ROUND_FULL` and `3xl` radii to create a modern, lightweight, and approachable feel.
- **Tonal Layering:** Utilize soft neutrals and background blurs to separate content without harsh borders.

## 2. Color Roles (Material 3 Basis)
- **Primary:** `#5D8233` (Brand Green) - Used for primary actions, active nav states, and success indicators.
- **On-Primary:** `#FFFFFF` (White) - Contrast text/icons on primary backgrounds.
- **Surface/Background:** `#fbf9f5` (Warm Neutral) - Main app background and container surfaces.
- **Surface-Variant:** `#f1eee8` (Soft Gray-Tan) - Search fields, segmented control backgrounds, and metadata chips.
- **Secondary/Accent:** `#A7E2FF` (Soft Blue) - Used for progress bars or secondary emphasis (e.g., "Resume Watching").
- **Text-Primary:** `#1b1c1a` (Deep Charcoal) - Headings and high-emphasis body text.
- **Text-Secondary:** `#1b1c1a/60` (Muted Charcoal) - Metadata, labels, and helper text.

## 3. Typography Hierarchy
- **Display/Headline:** `Noto Serif` (Bold) - Screen titles and film names.
- **Subheadline:** `Noto Serif` (Italic) - Original titles and secondary brand messaging.
- **Body:** `Manrope` (or System Sans) - Synopsis text and descriptive content.
- **Label/Metadata:** `Manrope` (Medium/Bold) - Nav labels, scores, years, and chips.
- **Button:** `Manrope` (Bold, 14pt+) - All-caps or title case for interactive elements.

## 4. Spacing & Radius Scale
- **Base Grid:** 8px.
- **Margins:** 16px (Lateral) / 24px (Vertical between sections).
- **Radius - ROUND_FULL:** Buttons, Search Bars, Nav Indicators, Segmented Controls.
- **Radius - 3xl (24px+):** Film Cards, Hero Posters, Main Containers.
- **Radius - xl (12px):** Metadata chips, smaller avatars.

## 5. Surface & Container Rules
- **TopAppBar:** Fixed, `#fbf9f5/80` background with `backdrop-blur-xl`.
- **BottomNavBar:** Fixed, rounded-top (`ROUND_FULL`), `#fbf9f5/80` blur.
- **Cards:** No borders; use subtle shadows (`shadow-sm`) or tonal contrast against the background.

## 6. Component Anatomy
### Card Anatomy (Film)
- **Media:** 2:3 or 16:9 Aspect Ratio with `rounded-3xl`.
- **Favorite Toggle:** Floating `ROUND_FULL` button in top-right.
- **Text Stack:** Vertical arrangement (Title > Original Title > Metadata Row).

### Input Field Rules
- **Shape:** `ROUND_FULL` (Pill-shaped).
- **Fill:** Surface-Variant (`#f1eee8`).
- **Icons:** Inset leading icon for search; clear trailing action if active.

### Chip Rules
- **Shape:** `ROUND_FULL`.
- **Visuals:** Subtle background fill with high-contrast text; used for categories, genres, and scores.

### Button Emphasis Levels
- **High:** Filled (`#5D8233`), White text, `ROUND_FULL`.
- **Medium:** Tonal fill (`#A7E2FF` or soft gray), `ROUND_FULL`.
- **Low:** Text-only or ghost buttons with icons.

## 7. App State Patterns
- **Loading:** Centered vertical stack with animated "Gathering Stories..." text and soft-fade transitions.
- **Empty:** Dashed-border container with illustrative icon, title ("A Quiet Hearth"), and clear CTA button.
- **Error:** Human-centric copy ("The wind has changed"), centered icon, and "Try Again" recovery button.
- **Refreshing:** 20% opacity black/gray overlay on stale content with a top-pinned "Updating..." banner.

## 8. Accessibility Guidance
- **Contrast:** Maintain AA standards for `#5D8233` on `#fbf9f5`.
- **Touch Targets:** Minimum 44x44px for all interactive zones (nav, hearts, buttons).
- **Hierarchy:** Use font-weight and size to differentiate primary information from metadata.
- **Semantics:** Meaningful alt-text for posters and labels for all icon-only buttons.