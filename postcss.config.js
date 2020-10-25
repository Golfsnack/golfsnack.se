let environment = {
  plugins: [
    require("postcss-import"),
    require("tailwindcss")("./app/javascript/stylesheets/tailwind.config.js"),
    require("autoprefixer"),
    require("postcss-flexbugs-fixes"),
    require("postcss-preset-env")({
      autoprefixer: {
        flexbox: "no-2009",
      },
      stage: 3,
    }),
  ],
};

// Add everything below!
if (process.env.RAILS_ENV === "production") {
  environment.plugins.push(
    require("@fullhuman/postcss-purgecss")({
      content: [
        "./app/**/.html.erb",
        "./app/helpers/**/*.rb",
        "./app/javascript/**/*.js",
      ],
      defaultExtractor: (content) => content.match(/[A-Za-z0-9-_:/]+/g) || [],
    })
  );
}

module.exports = environment;
