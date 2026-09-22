<!doctype html>
<html lang="en-US">
  <head>
  <meta charset="utf-8">
  <meta http-equiv="x-ua-compatible" content="ie=edge">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <link rel="preload" as="font" href="https://terraform-docs.io/fonts/vendor/jost/jost-v4-latin-regular.woff2" type="font/woff2" crossorigin>
<link rel="preload" as="font" href="https://terraform-docs.io/fonts/vendor/jost/jost-v4-latin-700.woff2" type="font/woff2" crossorigin>

  <link rel="stylesheet" href="https://terraform-docs.io/main.f064e46b70df0e66b127a84d5264b7c2a47043647591bbc0e60bfd5155bccff060e0f6a6f1beda5113c490d7af6a540f094684d71dee8c306dd11f20d3307e11.css" integrity="sha512-8GTka3DfDmaxJ6hNUmS3wqRwQ2R1kbvA5gv9UVW8z/Bg4Pam8b7aURPEkNevalQPCUaE1x3ujDBt0R8g0zB&#43;EQ==" crossorigin="anonymous">
<noscript><style>img.lazyload { display: none; }</style></noscript>

  <meta name="robots" content="index, follow">
    <meta name="googlebot" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">
    <meta name="bingbot" content="index, follow, max-snippet:-1, max-image-preview:large, max-video-preview:-1">
  <title>terraform-docs</title>
  <meta name="description" content="Generate Terraform modules documentation in various formats">
<link rel="canonical" href="https://terraform-docs.io/">
<meta property="og:locale" content="en_US">
<meta property="og:type" content="website">
<meta property="og:title" content="terraform-docs">
<meta property="og:description" content="Generate Terraform modules documentation in various formats">
<meta property="og:url" content="https://terraform-docs.io/">

  <meta property="og:image" content="https://terraform-docs.io/twitter-card_400x400.png"/>
    <meta property="og:site_name" content="terraform-docs">

<meta name="twitter:card" content="summary">
<meta name="twitter:site" content="">
<meta name="twitter:creator" content="">
<meta name="twitter:title" content="terraform-docs">
<meta name="twitter:description" content="Generate Terraform modules documentation in various formats">
<meta name="twitter:image" content="https://terraform-docs.io/twitter-card_400x400.png">
    <meta name="twitter:image:alt" content="terraform-docs">


<link rel="alternate" type="application/rss&#43;xml" href="https://terraform-docs.io/index.xml">
<script type="application/ld+json">
{
  "@context": "https://schema.org",
  "@graph": [
    {
      "@type": "Organization",
        "@id": "https://terraform-docs.io/#/schema/organization/1",
      "name": "",
      "url": "https://terraform-docs.io/",
      "sameAs": [
        , "https://github.com/terraform-docs"
        ],
      "logo": {
          "@type": "ImageObject",
          "@id": "https://terraform-docs.io/#/schema/image/1",
          "url": "https://terraform-docs.io/\u003cnil\u003e",
          "width":  null ,
          "height":  null ,
          "caption": ""
        },
        "image": {
          "@id": "https://terraform-docs.io/#/schema/image/1"
        }
      },
    {
      "@type": "WebSite",
      "@id": "https://terraform-docs.io/#/schema/website/1",
      "url": "https://terraform-docs.io/",
      "name": "terraform-docs",
      "description": "Generate documentation from Terraform modules in various output formats.",
      "publisher": {
          "@id": "https://terraform-docs.io/#/schema/organization/1"
        }
      },
    {
      "@type": "WebPage",
      "@id": "https://terraform-docs.io/",
      "url": "https://terraform-docs.io/",
      "name": "terraform-docs",
      "description": "Generate Terraform modules documentation in various formats",
      "isPartOf": {
        "@id": "https://terraform-docs.io/#/schema/website/1"
      },
      "about": {
          "@id": "https://terraform-docs.io/#/schema/organization/1"
        },
      "datePublished": "0001-01-01T00:00:00CET",
      "dateModified": "0001-01-01T00:00:00CET",
      "breadcrumb": {
        "@id": "https://terraform-docs.io/#/schema/breadcrumb/1"
      },
      "primaryImageOfPage": {
        "@id": "https://terraform-docs.io/#/schema/image/2"
      },
      "inLanguage": "",
      "potentialAction": [{
        "@type": "ReadAction", "target": ["https://terraform-docs.io/"]
      }]
    },
    {
      "@type": "BreadcrumbList",
      "@id": "https://terraform-docs.io/#/schema/breadcrumb/1",
      "name": "Breadcrumbs",
      "itemListElement": [{
        "@type": "ListItem",
        "position":  1 ,
        "item": {
          "@id": "https://terraform-docs.io"
          }
        }]
    },

    {
      "@context": "https://schema.org",
      "@graph": [
        {
          "@type": "ImageObject",
          "@id": "https://terraform-docs.io/#/schema/image/2",
          "url":  null ,
          "contentUrl":  null ,
          "caption": "terraform-docs"
        }
      ]
    }

  ]
}
</script>


  <meta name="theme-color" content="#fff">
<link rel="apple-touch-icon" sizes="180x180" href="https://terraform-docs.io/apple-touch-icon.png">
<link rel="icon" type="image/png" sizes="32x32" href="https://terraform-docs.io/favicon-32x32.png">
<link rel="icon" type="image/png" sizes="16x16" href="https://terraform-docs.io/favicon-16x16.png">
<link rel="manifest" href="https://terraform-docs.io/site.webmanifest">

  
</head>
  <body class="single">
    <div class="header-bar fixed-top"></div>

<header class="navbar sticky-top navbar-expand-md navbar-light doks-navbar">
  <nav class="container-xxl flex-wrap flex-md-nowrap" aria-label="Main navigation">
    <a class="navbar-brand p-0 me-auto" href="https://terraform-docs.io/" aria-label="Bootstrap">
      
        <img class="logo-light" src="https://terraform-docs.io/logo-full-light.png" height="45" alt="terraform-docs" />
        <img class="logo-dark" src="https://terraform-docs.io/logo-full-dark.png" height="45" alt="terraform-docs" />
      
    </a>

    <button class="btn btn-menu d-block d-md-none order-5" type="button" data-bs-toggle="offcanvas" data-bs-target="#offcanvasDoks" aria-controls="offcanvasDoks" aria-label="Open main menu">
      <svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-menu"><line x1="3" y1="12" x2="21" y2="12"></line><line x1="3" y1="6" x2="21" y2="6"></line><line x1="3" y1="18" x2="21" y2="18"></line></svg>
    </button>

    <div class="offcanvas offcanvas-start d-md-none border-0" tabindex="-1" id="offcanvasDoks" data-bs-backdrop="true" aria-labelledby="offcanvasDoksLabel">
      <div class="header-bar"></div>
      <div class="offcanvas-header">
        <h2 class="h5 offcanvas-title ps-2" id="offcanvasDoksLabel">
          <a class="text-dark" href="https://terraform-docs.io/">
            
              <img class="logo-light" src="https://terraform-docs.io/logo-full-light.png" height="45" alt="terraform-docs" />
              <img class="logo-dark" src="https://terraform-docs.io/logo-full-dark.png" height="45" alt="terraform-docs" />
            
          </a>
        </h2>
        <button type="button" class="btn-close text-reset me-2" data-bs-dismiss="offcanvas" aria-label="Close main menu"></button>
      </div>
      <div class="offcanvas-body px-4">
        <form class="doks-search position-relative flex-grow-1 me-auto">
          <input id="search-xs" class="form-control is-search" type="search" placeholder="Search docs..." aria-label="Search docs..." autocomplete="off">
        </form>

        <div class="docs-links">
          

<ul class="list-unstyled level-0">
  <li class="list-submenu level-0">
      <input type="checkbox" id="navtree-c88c54cb-64fbf75d" class="docs-toggle" >
      <label for="navtree-c88c54cb-64fbf75d">
      <h3>User Guide</h3>
      
      <svg class="icon arrow-right level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 32 32"><path d="M6.125 28.25l12.25-12.25-12.25-12.25 3.75-3.75 15.999 15.999-15.999 15.999z"></path></svg>
      <svg class="icon arrow-down level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 28 28"><path d="M3.281 5.36l10.719 10.719 10.719-10.719 3.281 3.281-14 14-14-14z"></path></svg>
      </label><ul class="list-unstyled level-1">
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/user-guide/introduction/" class="docs-link">
          Introduction
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/user-guide/installation/" class="docs-link">
          Installation
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <input type="checkbox" id="navtree-da39a3ee-301f1e3f" class="docs-toggle" >
      <label for="navtree-da39a3ee-301f1e3f"><a href="https://terraform-docs.io/user-guide/configuration/" class="docs-link">
          Configuration
      </a>
      
      <svg class="icon arrow-right level-1" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 32 32"><path d="M6.125 28.25l12.25-12.25-12.25-12.25 3.75-3.75 15.999 15.999-15.999 15.999z"></path></svg>
      <svg class="icon arrow-down level-1" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 28 28"><path d="M3.281 5.36l10.719 10.719 10.719-10.719 3.281 3.281-14 14-14-14z"></path></svg>
      </label><ul class="list-unstyled level-2">
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/content/" class="docs-link">
          content
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/footer-from/" class="docs-link">
          footer-from
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/formatter/" class="docs-link">
          formatter
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/header-from/" class="docs-link">
          header-from
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/output/" class="docs-link">
          output
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/output-values/" class="docs-link">
          output-values
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/recursive/" class="docs-link">
          recursive
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/sections/" class="docs-link">
          sections
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/settings/" class="docs-link">
          settings
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/sort/" class="docs-link">
          sort
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/user-guide/configuration/version/" class="docs-link">
          version
      </a>
      
    </li>
  </ul>

    </li>
  </ul>

    </li>
  <li class="list-submenu level-0">
      <input type="checkbox" id="navtree-92b69650-7fcdc1a4" class="docs-toggle" >
      <label for="navtree-92b69650-7fcdc1a4">
      <h3>How To&#39;s</h3>
      
      <svg class="icon arrow-right level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 32 32"><path d="M6.125 28.25l12.25-12.25-12.25-12.25 3.75-3.75 15.999 15.999-15.999 15.999z"></path></svg>
      <svg class="icon arrow-down level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 28 28"><path d="M3.281 5.36l10.719 10.719 10.719-10.719 3.281 3.281-14 14-14-14z"></path></svg>
      </label><ul class="list-unstyled level-1">
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/cli-flag-false-value/" class="docs-link">
          CLI Flag &#39;false&#39; value
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/configuration-file/" class="docs-link">
          Configuration File
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/visibility-of-sections/" class="docs-link">
          Visibility of Sections
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/ignore-resources/" class="docs-link">
          Ignore Resources to be Generated
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/insert-output-to-file/" class="docs-link">
          Insert Output To File
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/include-examples/" class="docs-link">
          Include Examples
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/recursive-submodules/" class="docs-link">
          Recursive Submodules
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/generate-terraform-tfvars/" class="docs-link">
          Generate terraform.tfvars
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/github-action/" class="docs-link">
          GitHub Action
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/how-to/pre-commit-hooks/" class="docs-link">
          pre-commit Hooks
      </a>
      
    </li>
  </ul>

    </li>
  <li class="list-submenu level-0">
      <input type="checkbox" id="navtree-bfd51c3b-3315ca62" class="docs-toggle" >
      <label for="navtree-bfd51c3b-3315ca62">
      <h3>Developer Guide</h3>
      
      <svg class="icon arrow-right level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 32 32"><path d="M6.125 28.25l12.25-12.25-12.25-12.25 3.75-3.75 15.999 15.999-15.999 15.999z"></path></svg>
      <svg class="icon arrow-down level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 28 28"><path d="M3.281 5.36l10.719 10.719 10.719-10.719 3.281 3.281-14 14-14-14z"></path></svg>
      </label><ul class="list-unstyled level-1">
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/developer-guide/plugins/" class="docs-link">
          Plugins
      </a>
      
    </li>
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/developer-guide/contributing/" class="docs-link">
          Contributing
      </a>
      
    </li>
  </ul>

    </li>
  <li class="list-submenu level-0">
      <input type="checkbox" id="navtree-fe79a596-cfc39972" class="docs-toggle" >
      <label for="navtree-fe79a596-cfc39972">
      <h3>Reference</h3>
      
      <svg class="icon arrow-right level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 32 32"><path d="M6.125 28.25l12.25-12.25-12.25-12.25 3.75-3.75 15.999 15.999-15.999 15.999z"></path></svg>
      <svg class="icon arrow-down level-0" version="1.1" xmlns="http://www.w3.org/2000/svg" width="10" height="10" viewBox="0 0 28 28"><path d="M3.281 5.36l10.719 10.719 10.719-10.719 3.281 3.281-14 14-14-14z"></path></svg>
      </label><ul class="list-unstyled level-1">
  <li class="list-submenu level-1">
      <a href="https://terraform-docs.io/reference/terraform-docs/" class="docs-link active">
          terraform-docs
      </a>
      <ul class="list-unstyled level-2">
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/asciidoc/" class="docs-link">
          asciidoc
      </a>
      <ul class="list-unstyled level-3">
  <li class="list-submenu level-3">
      <a href="https://terraform-docs.io/reference/asciidoc-document/" class="docs-link">
          asciidoc document
      </a>
      
    </li>
  <li class="list-submenu level-3">
      <a href="https://terraform-docs.io/reference/asciidoc-table/" class="docs-link">
          asciidoc table
      </a>
      
    </li>
  </ul>

    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/json/" class="docs-link">
          json
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/markdown/" class="docs-link">
          markdown
      </a>
      <ul class="list-unstyled level-3">
  <li class="list-submenu level-3">
      <a href="https://terraform-docs.io/reference/markdown-document/" class="docs-link">
          markdown document
      </a>
      
    </li>
  <li class="list-submenu level-3">
      <a href="https://terraform-docs.io/reference/markdown-table/" class="docs-link">
          markdown table
      </a>
      
    </li>
  </ul>

    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/pretty/" class="docs-link">
          pretty
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/tfvars/" class="docs-link">
          tfvars
      </a>
      <ul class="list-unstyled level-3">
  <li class="list-submenu level-3">
      <a href="https://terraform-docs.io/reference/tfvars-hcl/" class="docs-link">
          tfvars hcl
      </a>
      
    </li>
  <li class="list-submenu level-3">
      <a href="https://terraform-docs.io/reference/tfvars-json/" class="docs-link">
          tfvars json
      </a>
      
    </li>
  </ul>

    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/toml/" class="docs-link">
          toml
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/xml/" class="docs-link">
          xml
      </a>
      
    </li>
  <li class="list-submenu level-2">
      <a href="https://terraform-docs.io/reference/yaml/" class="docs-link">
          yaml
      </a>
      
    </li>
  </ul>

    </li>
  </ul>

    </li>
  </ul>

        </div>

        
        <hr class="text-black-50 my-4">
        <h3 class="h6 text-uppercase mb-3">Socials</h3>
        <ul class="nav flex-column">
          <li class="nav-item">
              <a class="nav-link py-1" href="https://github.com/terraform-docs/terraform-docs/"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-github"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg><small class="ms-2">GitHub</small></a>
            </li>
          </ul>
      </div>
    </div>

    <button id="mode" class="btn btn-link order-md-1" type="button" aria-label="Toggle user interface mode">
      <span class="toggle-dark"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-moon"><path d="M21 12.79A9 9 0 1 1 11.21 3 7 7 0 0 0 21 12.79z"></path></svg></span>
      <span class="toggle-light"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-sun"><circle cx="12" cy="12" r="5"></circle><line x1="12" y1="1" x2="12" y2="3"></line><line x1="12" y1="21" x2="12" y2="23"></line><line x1="4.22" y1="4.22" x2="5.64" y2="5.64"></line><line x1="18.36" y1="18.36" x2="19.78" y2="19.78"></line><line x1="1" y1="12" x2="3" y2="12"></line><line x1="21" y1="12" x2="23" y2="12"></line><line x1="4.22" y1="19.78" x2="5.64" y2="18.36"></line><line x1="18.36" y1="5.64" x2="19.78" y2="4.22"></line></svg></span>
    </button>
    <div class="collapse navbar-collapse" id="doksNavbar">
      <ul class="navbar-nav flex-row flex-wrap pt-2 py-md-0"></ul>
      <hr class="d-md-none text-black-50">
      <ul class="navbar-nav flex-row flex-wrap ms-md-auto me-md-1">
        <li class="nav-item col-8 col-md-auto">
          <form class="doks-search position-relative flex-grow-1 me-auto">
            <input id="search-lg" class="form-control is-search" type="search" placeholder="Search docs..." aria-label="Search docs..." autocomplete="off">
          </form>
        </li>
        <li class="nav-item col-8 col-md-auto">
            <a class="nav-link py-2" href="https://github.com/terraform-docs/terraform-docs/"><svg xmlns="http://www.w3.org/2000/svg" width="20" height="20" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-github"><path d="M9 19c-5 1.5-5-2.5-7-3m14 6v-3.87a3.37 3.37 0 0 0-.94-2.61c3.14-.35 6.44-1.54 6.44-7A5.44 5.44 0 0 0 20 4.77 5.07 5.07 0 0 0 19.91 1S18.73.65 16 2.48a13.38 13.38 0 0 0-7 0C6.27.65 5.09 1 5.09 1A5.07 5.07 0 0 0 5 4.77a5.44 5.44 0 0 0-1.5 3.78c0 5.42 3.3 6.61 6.44 7A3.37 3.37 0 0 0 9 18.13V22"></path></svg><small class="d-md-none ms-2">GitHub</small></a>
          </li>
        </ul>
    </div>
  </nav>
</header>







    <div class="wrap container-xxl" role="document">
      <div class="content">
        
<section class="section container-fluid mt-n3 pb-3">
  <div class="row justify-content-center">
    <div class="col-lg-12 text-center">
      <h1 class="mt-0">terraform-docs</h1>
    </div>
    <div class="col-lg-9 col-xl-8 text-center">
      <p class="lead">Generate Terraform modules documentation in various formats</p>
      <br />
      <a class="btn btn-primary btn-md px-4 mb-2" href="https://terraform-docs.io/user-guide/introduction/" role="button">Get started</a>
      <a class="btn btn-outline-primary btn-md px-4 mb-2" href="https://github.com/terraform-docs/terraform-docs/" role="button">Go to GitHub</a>
    </div>
  </div>
</section>

      </div>
    </div>
    
<div class="d-flex justify-content-start">
  <div class="bg-dots"></div>
</div>

<section class="section section-sm">
  <div class="container">
    <div class="row justify-content-center text-centerx text-left">
      <div class="col-lg-5">
        <h2 class="h4">Multiple formats</h2>
        <p class="text-left">Markdown, AsciiDoc, JSON, and more. Check out all available <a href="https://terraform-docs.io/user-guide/configuration/formatter">formats</a>.</p>
      </div>
      <div class="col-lg-5">
        <h2 class="h4">Extensible</h2>
        <p>Extend terraform-docs by <a href="https://terraform-docs.io/developer-guide/plugins/">Plugin</a> and build your own formatter.</div>
      <div class="col-lg-5">
        <h2 class="h4">CI-friendly</h2>
        <p>Automate document generation in pull requests with <a href="https://terraform-docs.io/how-to/github-action/">GitHub Action</a>.</p>
      </div>
    </div>
  </div>
</section>

    
    <footer class="footer text-muted">
  <div class="container-xxl">
    <div class="row">
      <div class="col-lg-8 order-last order-lg-first">
        <ul class="list-inline">
          <li class="list-inline-item">  &copy; terraform-docs Authors 2023.
  Documentation distributed under <a href="https://creativecommons.org/licenses/by/4.0/">CC-BY-4.0</a>.
</li>
        </ul>
      </div>
      <div class="col-lg-8 order-first order-lg-last text-lg-end">
        <ul class="list-inline">
          <li class="list-inline-item"><a href="https://github.com/terraform-docs/terraform-docs/">GitHub</a></li>
          <li class="list-inline-item"><a href="https://slack.terraform-docs.io/">Slack</a></li>
          </ul>
      </div>
    </div></div>
</footer>

    <script src="https://terraform-docs.io/js/bootstrap.min.592b9faf6c83a2bda564a377cf82f9a67546b198510a93fdb0728f9622ec22729d44be02fb2ea16c3fe5365ae1806259cd111932ca28e68b66462d6937635bab.js" integrity="sha512-WSufr2yDor2lZKN3z4L5pnVGsZhRCpP9sHKPliLsInKdRL4C&#43;y6hbD/lNlrhgGJZzREZMsoo5otmRi1pN2Nbqw==" crossorigin="anonymous" defer></script>
  <script src="https://terraform-docs.io/js/highlight.min.c6f0c5c3312a80f38a5dde6252548807e110d084d1f1be963506d397fbbbc2060f2e18c8b227599025a47e9447f57712510181e4cb94c81d601782b15deab4a6.js" integrity="sha512-xvDFwzEqgPOKXd5iUlSIB&#43;EQ0ITR8b6WNQbTl/u7wgYPLhjIsidZkCWkfpRH9XcSUQGB5MuUyB1gF4KxXeq0pg==" crossorigin="anonymous" defer></script>
  <script src="https://terraform-docs.io/js/vendor/docsearch.js/dist/cdn/docsearch.min.min.574fb52bef6f3099cd10ebe7f780b7035fd64dc6d2616bf8e942efe0fe182c1c558d260f7d094a7b576a92f643490345a4d9ec733bded7a27e274569b39b028f.js" integrity="sha512-V0&#43;1K&#43;9vMJnNEOvn94C3A1/WTcbSYWv46ULv4P4YLBxVjSYPfQlKe1dqkvZDSQNFpNnsczve16J&#43;J0Vps5sCjw==" crossorigin="anonymous" defer></script>
  <script src="https://terraform-docs.io/main.min.1f64fa9d5a5086ca7e3439037c1256913df1d6d868a3d307b7d8872d6f69f27f26f2d3f947feabf8c7cb8389ad2169214f388e1f1b6588669710c1aeb87f67dc.js" integrity="sha512-H2T6nVpQhsp&#43;NDkDfBJWkT3x1thoo9MHt9iHLW9p8n8m8tP5R/6r&#43;MfLg4mtIWkhTziOHxtliGaXEMGuuH9n3A==" crossorigin="anonymous" defer></script>
  
  
  <script async src="https://www.googletagmanager.com/gtag/js?id=UA-190560615-1"></script>
  <script nonce="gtagmanager">
    window.dataLayer = window.dataLayer || [];
    function gtag(){dataLayer.push(arguments);}
    gtag('js', new Date());

    gtag('config', 'UA-190560615-1');
  </script>
  

  </body>
</html>
