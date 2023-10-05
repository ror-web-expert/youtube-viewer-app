module.exports = {
  content: ["./**/*.html", "./js/**/*.js"],
  theme: {
    extend: {
      fontFamily: {
        inter: ["Inter", "sans-serif"],
        nycd: ["Nothing You Could Do", "cursive"],
      },
      fontSize: {
        xs: ["0.75rem", { lineHeight: "1.5" }],
        sm: ["0.875rem", { lineHeight: "1.5715" }],
        base: ["1rem", { lineHeight: "1.5", letterSpacing: "-0.01em" }],
        lg: ["1.125rem", { lineHeight: "1.5", letterSpacing: "-0.01em" }],
        xl: ["1.25rem", { lineHeight: "1.5", letterSpacing: "-0.01em" }],
        "2xl": ["1.5rem", { lineHeight: "1.415", letterSpacing: "-0.01em" }],
        "3xl": ["1.875rem", { lineHeight: "1.333", letterSpacing: "-0.01em" }],
        "4xl": ["2.25rem", { lineHeight: "1.277", letterSpacing: "-0.01em" }],
        "5xl": ["3rem", { lineHeight: "1", letterSpacing: "-0.01em" }],
        "6xl": ["3.75rem", { lineHeight: "1", letterSpacing: "-0.01em" }],
        "7xl": ["4.5rem", { lineHeight: "1", letterSpacing: "-0.01em" }],
      },
      letterSpacing: {
        tighter: "-0.02em",
        tight: "-0.01em",
        normal: "0",
        wide: "0.01em",
        wider: "0.02em",
        widest: "0.4em",
      },
    },
  },
  plugins: [
    // eslint-disable-next-line global-require
    require("@tailwindcss/forms"),
    require("@tailwindcss/aspect-ratio"),
    require("@tailwindcss/typography"),
    require("@tailwindcss/container-queries"),
  ],
};

// const defaultTheme = require('tailwindcss/defaultTheme')

// module.exports = {
//   content: [
//     './public/*.html',
//     './app/helpers/**/*.rb',
//     './app/javascript/**/*.js',
//     './app/views/**/*.{erb,haml,html,slim}'
//   ],
//   theme: {
//     extend: {
//       fontFamily: {
//         sans: ['Inter var', ...defaultTheme.fontFamily.sans],
//       },
//       inset: {
//         '15px': '15px',
//       },
//       container: {
//         center: true,
//         screens: {
//           'sm': '640px',
//           // => @media (min-width: 640px) { ... }

//           'md': '768px',
//           // => @media (min-width: 768px) { ... }

//           'lg': '1024px',
//           // => @media (min-width: 1024px) { ... }

//           'xl': '1280px',
//           // => @media (min-width: 1280px) { ... }

//           '2xl': '1536px',
//           // => @media (min-width: 1536px) { ... }
//         }
//       }
//     },
//   },
//   plugins: [
//     require('@tailwindcss/forms'),
//     require('@tailwindcss/aspect-ratio'),
//     require('@tailwindcss/typography'),
//     require('@tailwindcss/container-queries'),
//   ]
// }
