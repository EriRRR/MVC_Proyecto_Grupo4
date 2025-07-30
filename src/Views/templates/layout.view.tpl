<!DOCTYPE html>
<html>
<head>


  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>{{SITE_TITLE}}</title>
  <link rel="preconnect" href="https://fonts.gstatic.com">
  <link href="https://fonts.googleapis.com/css2?family=Roboto&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="/{{BASE_DIR}}/public/css/appstyle.css" />
  <script src="https://kit.fontawesome.com/{{FONT_AWESOME_KIT}}.js" crossorigin="anonymous"></script>
  {{foreach SiteLinks}}
    <link rel="stylesheet" href="/{{~BASE_DIR}}/{{this}}" />
  {{endfor SiteLinks}}
  {{foreach BeginScripts}}
    <script src="/{{~BASE_DIR}}/{{this}}"></script>
  {{endfor BeginScripts}} 
</head> 


<body>
 <header style="background-color: #292d2bff; color: white;">
    <input type="checkbox" class="menu_toggle" id="menu_toggle" />
    <label for="menu_toggle" class="menu_toggle_icon" >
      <div class="hmb dgn pt-1"></div>
      <div class="hmb hrz"></div>
      <div class="hmb dgn pt-2"></div>
    </label>
    <h1>{{SITE_TITLE}}</h1>
    <nav id="menu">
      <ul>
        <li><a href="index.php?page={{PUBLIC_DEFAULT_CONTROLLER}}"><i class="fas fa-home"></i>&nbsp;Inicio</a></li>
        {{foreach PUBLIC_NAVIGATION}}
            <li><a href="{{nav_url}}">{{nav_label}}</a></li>
        {{endfor PUBLIC_NAVIGATION}}
      </ul>
    </nav>
 <a href="index.php?page=Cart-Show" 
       style="position: absolute; top: 1rem; right: 1rem; font-size: 1.8rem; color: #238a3d;; text-decoration: none;">
      <i class="fas fa-shopping-cart"></i>
      <span style="
        position: absolute;
        top: -8px;
        right: -12px;
        background: #292d2bff;;
        color: #292d2bff;;
        border-radius: 50%;
        padding: 2px 6px;
        font-size: 0.75rem;
        font-weight: bold;
        min-width: 20px;
        text-align: center;
        line-height: 1;
      ">
        {{if ~CART_ITEMS}}{{~CART_ITEMS}}{{endif ~CART_ITEMS}}
      </span>
    </a>
     <span>{{if ~CART_ITEMS}}{{~CART_ITEMS}}{{endif ~CART_ITEMS}}</span>

     

  </header>
  <main>
  {{{page_content}}}
  </main>
 <footer style="background-color: #292d2bff; color: white; padding: 1rem; text-align: center;">
  <div>Todo los Derechos Reservados grupo 4 {{~CURRENT_YEAR}} &copy;</div>
</footer>


  {{foreach EndScripts}}
    <script src="/{{~BASE_DIR}}/{{this}}"></script>
  {{endfor EndScripts}}
</body>
</html>
