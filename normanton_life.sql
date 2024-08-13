-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Host: mysql.normanton.life
-- Generation Time: Aug 13, 2024 at 12:25 PM
-- Server version: 8.0.28-0ubuntu0.20.04.3
-- PHP Version: 8.1.2-1ubuntu2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `normanton_life`
--

-- --------------------------------------------------------

--
-- Table structure for table `articles`
--

CREATE TABLE `articles` (
  `id` int NOT NULL,
  `slug` varchar(80) NOT NULL DEFAULT '',
  `section` varchar(20) NOT NULL,
  `author` varchar(20) NOT NULL,
  `waiting` tinyint(1) NOT NULL DEFAULT '0',
  `pub` tinyint(1) NOT NULL DEFAULT '0',
  `published` int NOT NULL,
  `ts` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `articles`
--

INSERT INTO `articles` (`id`, `slug`, `section`, `author`, `waiting`, `pub`, `published`, `ts`) VALUES
(1, 'left', '', 'nlife', 0, 1, 1722553200, 1723555305),
(2, 'right', '', 'nlife', 0, 1, 1722639600, 1723569096),
(3, 'welcome', 'general', 'nlife', 0, 1, 1722726000, 1723413442),
(4, 'faith-in-normanton', 'faith', 'tramontana', 0, 1, 1723590000, 1723576871),
(8, 'sport-in-normanton', 'sport', 'tramontana', 0, 1, 1723503600, 1723558239),
(9, 'litter-picking', 'community', 'tramontana', 0, 1, 1723330800, 1723554524),
(10, 'technical', '', 'nlife', 0, 1, 1722466800, 1723559617),
(11, 'easycoder', '', 'nlife', 0, 1, 1722466800, 1723554873),
(13, 'about', 'general', 'nlife', 0, 1, 1722466800, 1723559907),
(14, 'contributions', '', 'nlife', 0, 1, 1722553200, 1723574945);

-- --------------------------------------------------------

--
-- Table structure for table `ec_data`
--

CREATE TABLE `ec_data` (
  `id` int NOT NULL,
  `name` varchar(40) NOT NULL DEFAULT '',
  `value` text NOT NULL,
  `ts` int NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `ec_data`
--

INSERT INTO `ec_data` (`id`, `name`, `value`, `ts`) VALUES
(1, 'key', 'AIzaSyDTWe5hoygkgkO96XRsEbrgi1Daty1uJvQ', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ec_html`
--

CREATE TABLE `ec_html` (
  `id` int NOT NULL,
  `name` varchar(40) NOT NULL,
  `value` text NOT NULL,
  `ts` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `ec_html`
--

INSERT INTO `ec_html` (`id`, `name`, `value`, `ts`) VALUES
(1, 'left', '<p>The left panel</p>', 1546729502),
(2, 'facebook', '            <h4 id=~dq~facebook~dq~>               Follow us on Facebook            </h4>            <iframe src=~dq~https://www.facebook.com/plugins/page.php?href=https%3A%2F%2Fwww.facebook.com%2FYorkshireWomanPage%2F&tabs=timeline&width=250&height=450&small_header=false&adapt_container_width=true&hide_cover=false&show_facepile=true&appId=213380182040529~dq~ width=~dq~250~dq~ height=~dq~450~dq~ style=~dq~border:none;overflow:hidden~dq~ scrolling=~dq~no~dq~ frameborder=~dq~0~dq~ allowTransparency=~dq~true~dq~ allow=~dq~encrypted-media~dq~></iframe>', 1554737727),
(3, 'facebook2', '<div class=~dq~fb-page~dq~ data-href=~dq~https://www.facebook.com/YorkshireWomanPage/~dq~ data-tabs=~dq~timeline~dq~ data-width=~dq~250~dq~ data-height=~dq~450~dq~ data-small-header=~dq~false~dq~ data-adapt-container-width=~dq~true~dq~ data-hide-cover=~dq~false~dq~ data-show-facepile=~dq~true~dq~><blockquote cite=~dq~https://www.facebook.com/YorkshireWomanPage/~dq~ class=~dq~fb-xfbml-parse-ignore~dq~><a href=~dq~https://www.facebook.com/YorkshireWomanPage/~dq~>Yorkshire Woman</a></blockquote></div>', 1554737526);

-- --------------------------------------------------------

--
-- Table structure for table `ec_scripts`
--

CREATE TABLE `ec_scripts` (
  `id` int NOT NULL,
  `name` varchar(40) NOT NULL,
  `value` text NOT NULL,
  `ts` int NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `ec_scripts`
--

INSERT INTO `ec_scripts` (`id`, `name`, `value`, `ts`) VALUES
(1, 'fileman', '! File Manager%0a%0a  script FileManager%0a%0a  import div Container%0a%0a  div Mask%0a  div Panel%0a  div FileListing%0a  div FileRow%0a  div Scroller%0a  div Uploader%0a  div Buttons%0a  span UploadStatus%0a  progress UploadProgress%0a  input UploadFile%0a  button CloseButton%0a  button NewFolderButton%0a  button ShowURLButton%0a  button UploadButton%0a  button DeleteButton%0a  a FileName%0a  img Icon%0a  img Image%0a  variable Alpha%0a  variable FileCount%0a  variable File%0a  variable FileList%0a  variable Name%0a  variable Type%0a  variable Source%0a  variable Content%0a  variable CurrentPath%0a  variable Separator%0a  variable Path%0a  variable N%0a  variable Even%0a  variable Progress%0a  variable Status%0a%0a  history push%0a  create Mask in Container%0a  set the style of Mask to `display:none;position:fixed;top:0;left:0;right:0;bottom:0;`%0a    cat `width:100%;height:100%;z-index:5;background-color:rgba(0,0,0,0.0);text-align:center`%0a  create Panel in Mask%0a  if mobile%0a    set the style of Panel to%0a      `width:100%;height:100%;background:#ffe`%0a  else%0a    set the style of Panel to%0a      `width:50%;height:90%;margin-top:5%;margin-left:25%;background:#ffe;border:3px solid black`%0a%0a  create Uploader in Panel%0a  set the style of Uploader to%0a    `position:relative;top:0;width:100%;padding:0.5em 0;border:1px solid gray;font-size:80%`%0a  set the content of Uploader to `Select a file: `%0a  create UploadFile in Uploader%0a  set attribute `type` of UploadFile to `file`%0a  set attribute `name` of UploadFile to `Source`%0a  create UploadStatus in Uploader%0a  create UploadProgress in Uploader%0a  set style `margin-left` of UploadProgress to `0.5em`%0a  set attribute `value` of UploadProgress to 0%0a  set attribute `max` of UploadProgress to 100%0a%0a  create Buttons in Panel%0a  set the style of Buttons to `position:relative;top:10px`%0a  create CloseButton in Buttons%0a  set the style of CloseButton to `width:150px;height:40px`%0a  set the text of CloseButton to `Close`%0a  create DeleteButton in Buttons%0a  set the style of DeleteButton to `width:150px;height:40px`%0a  set the text of DeleteButton to `Delete`%0a  on click CloseButton history back%0a  create NewFolderButton in Buttons%0a  set the style of NewFolderButton to `width:150px;height:40px`%0a  set the text of NewFolderButton to `New Folder`%0a  create ShowURLButton in Buttons%0a  set the style of ShowURLButton to `display:none;width:150px;height:40px`%0a  set the text of ShowURLButton to `Show URL`%0a  create UploadButton in Buttons%0a  set the style of UploadButton to `width:150px;height:40px`%0a  set the text of UploadButton to `Upload`%0a  on click UploadButton go to Upload%0a%0a  create FileListing in Panel%0a  set the style of FileListing to `position:relative;top:40px;width:100%;height:80%;text-align:center`%0a  create Scroller in FileListing%0a  set the style of Scroller to%0a    `position:absolute;top:0;left:0;bottom:0;right:0;text-align:left;overflow-y:scroll`%0a  create Image in FileListing%0a  set the style of Image to `display:none;display: block;margin: 0 auto;max-width:100%;max-height:100%`%0a%0a  on close%0a  begin%0a    set style `display` of Panel to `none`%0a    put 8 into Alpha%0a    while Alpha is greater than 0%0a    begin%0a      take 1 from Alpha%0a      set style `background-color` of Mask to `rgba(0,0,0,0.` cat Alpha cat `)`%0a      wait 4 ticks%0a    end%0a    set style `display` of Mask to `none`%0a  end%0a%0a  on click NewFolderButton%0a  begin%0a    put prompt `Name of folder:` with `new` into Path%0a    if Path is empty stop%0a    replace ` ` with `-` in Path%0a    put `/home/yorkshirewoman/yorkshirewoman.uk/resources/` cat CurrentPath cat `/` cat Path into Path%0a    rest post Path to `_mkdir`%0a    or begin%0a      alert `Failed to create a directory.`%0a      stop%0a    end%0a    goto Browser%0a  end%0a%0a  on message go to Show%0a  set ready%0a  stop%0a%0aShow:%0a  set style `display` of Mask to `block`%0a  set style `display` of Panel to `block`%0a  put 0 into Alpha%0a  while Alpha is less than 8%0a  begin%0a    set style `background-color` of Mask to `rgba(0,0,0,0.` cat Alpha cat `)`%0a    wait 4 ticks%0a    add 1 to Alpha%0a  end%0a  wait 10 ticks%0a  set style `display` of FileListing to `block`%0a%0a! Fill the browser with content from the server%0a  put empty into CurrentPath%0a%0a! Fill the browser with content from the server%0a  get CurrentPath from storage as `fm-path`%0a%0a! Build the list%0aBrowser:%0a  put CurrentPath into storage as `fm-path`%0a  rest get Content from `_list` cat CurrentPath cat `/`%0a  or begin%0a    alert `Failed to list files.`%0a    stop%0a  end%0a  put empty into FileList%0a  put the json count of Content into FileCount%0a  set the elements of File to FileCount%0a  set the elements of FileName to FileCount%0a%0a! Add a row for each file%0a  set the content of Scroller to ``%0a  set Even%0a%0a  if CurrentPath is not empty%0a  begin%0a    create FileRow in Scroller%0a    set the style of FileRow to `width:90%;padding:0.5em 1em;text-align:left`%0a    create Icon in FileRow%0a    set the style of Icon to `float:left;margin-right:0.5em;width:20px`%0a    set attribute `src` of Icon to `https://yorkshirewoman.uk/resources/system/arrow-back.png`%0a    create FileName in FileRow%0a    set the content of FileName to `(back to previous folder)`%0a    on click FileName%0a    begin%0a      put the position of the last `~` in CurrentPath into N%0a      if N is less than 0 put the position of the last `/` in CurrentPath into N%0a      put left N of CurrentPath into CurrentPath%0a      go to Browser%0a    end%0a  end%0a%0a  set the elements of FileName to FileCount%0a  put 0 into N%0a  while N is less than FileCount%0a  begin%0a    index File to N%0a    put element N of Content into File%0a    put property `name` of File into Name%0a    put property `type` of File into Type%0a    create FileRow in Scroller%0a    set the style of FileRow to `clear:both;padding:0.5em 1em;text-align:left`%0a    if Even set style `background` of FileRow to `#eee`%0a    create Icon in FileRow%0a    set the style of Icon to `float:left;margin-right:0.5em;width:20px`%0a    if Type is `dir` put `folder.png` into Source%0a    else if Type is `img` put `image.png` into Source%0a    else if Type is `txt` put `text.png` into Source%0a    else if Type is `doc` put `document.png` into Source%0a    else put `unknown.png` into Source%0a    set attribute `src` of Icon to `https://yorkshirewoman.uk/resources/system/` cat Source%0a    index FileName to N%0a    create FileName in FileRow%0a    set the content of FileName to Name%0a    on click FileName go to SelectFile%0a    toggle Even%0a    add 1 to N%0a  end%0a%0a  on click DeleteButton%0a  begin%0a    if FileCount is 0%0a    begin%0a      rest post `/home/yorkshirewoman/yorkshirewoman.uk/resources` cat CurrentPath to `_delete`%0a      or begin%0a        alert `Failed to delete a file.`%0a        stop%0a      end%0a      put the position of the last `~` in CurrentPath into N%0a      if N is less than 0 put the position of the last `/` in CurrentPath into N%0a      put left N of CurrentPath into CurrentPath%0a      go to Browser%0a    end%0a    else%0a    begin%0a      alert `Folder is not empty`%0a    end%0a  end%0a%0a  stop%0a%0aSelectFile:%0a  index File to the index of FileName%0a  put property `type` of File into Type%0a  if Type is `dir`%0a  begin%0a    if CurrentPath is empty put `/` into Separator%0a    else put `~` into Separator%0a    put CurrentPath cat Separator cat the content of FileName into CurrentPath%0a    goto Browser%0a  end%0a  if Type is `img`%0a  begin%0a    set style `display` of Uploader to `none`%0a    set style `display` of UploadButton to `none`%0a    set style `display` of NewFolderButton to `none`%0a%0a    set style `display` of Scroller to `none`%0a    set style `display` of Image to `block`%0a    put CurrentPath cat `/` cat property `name` of File into Path%0a    replace `~` with `/` in Path%0a    set attribute `src` of Image to `https://yorkshirewoman.uk/resources` cat Path%0a    on click CloseButton go to CloseMedia%0a    set style `display` of ShowURLButton to `inline-block`%0a    on click ShowURLButton%0a    begin%0a      put prompt `URL of this image:` with `https://yorkshirewoman.uk/resources` cat Path into Path%0a    end%0a    on click DeleteButton%0a    begin%0a      rest post `/home/yorkshirewoman/yorkshirewoman.uk/resources/` cat Path to `_delete`%0a      or begin%0a        alert `Failed to delete the image.`%0a        stop%0a      end%0a      go to CloseMedia%0a    end%0a  end%0a  stop%0a%0aCloseMedia:%0a  set style `display` of Image to `none`%0a  set style `display` of Scroller to `block`%0a  set style `display` of Uploader to `inline-block`%0a  set style `display` of UploadButton to `inline-block`%0a  set style `display` of NewFolderButton to `inline-block`%0a  set style `display` of ShowURLButton to `none`%0a  on click CloseButton history back%0a  go to Browser%0a%0aUpload:%0a  if UploadFile is empty alert `Please choose a file to upload`%0a  else%0a  begin%0a    put `/home/yorkshirewoman/yorkshirewoman.uk/resources` cat CurrentPath into Path%0a    upload UploadFile to Path with UploadProgress and UploadStatus%0a    goto Browser%0a  end%0a  stop%0a%0a', 1554377281),
(7, 'left', '  script LeftPanel%0a%0a  import div Container%0a%0a  div Inner%0a  div Block1%0a  div Weather%0a  div FBDiv%0a  div Padding%0a  img EditButton%0a  variable Content%0a  variable Mode%0a  variable FacebookDone%0a  variable WeatherDone%0a%0a  create Inner in Container%0a  set the style of Inner to `margin:5% 5%`%0a%0a  create EditButton in Inner%0a  set the style of EditButton to `width:25px;display:none`%0a  set attribute `src` of EditButton to `https://yorkshirewoman.uk/resources/system/edit.png`%0a  set attribute `title` of EditButton to `Edit the left sidebar article`%0a  on click EditButton send `editleft` to parent%0a%0a  create Block1 in Inner%0a  set the style of Block1 to%0a    `padding-bottom:1em;border-bottom:1px solid lightgray;margin-bottom:1em`%0a%0a  on message go to Show%0a  set ready%0a  stop%0a%0aShow:%0a  get Mode from storage as `mode`%0a  if Mode is `admin` set style `display` of EditButton to `block`%0a  else set style `display` of EditButton to `none`%0a  rest get Content from `_/yw_articles/slug/left`%0a  or begin%0a    alert `Failed to get the content of the left panel.`%0a    stop%0a  end%0a  set the content of Block1 to decode property `article` of Content%0a%0a  if not FacebookDone%0a  begin%0a    create FBDiv in Inner%0a    set the style of FBDiv to `padding-bottom:1em;border-bottom:1px solid lightgray`%0a    rest get Content from `ec_html/name/facebook`%0a    set the content of FBDiv to Content%0a    create Padding in Inner%0a    set the content of Padding to `&nbsp;`%0a  end%0a%0a  if not WeatherDone%0a  begin%0a    create Weather in Inner%0a    set attribute `id` of Weather to `cont_d8f5d58c339aa6fbea3a58d369d5c0b9`%0a    require js `https://www.yourweather.co.uk/wid_loader/d8f5d58c339aa6fbea3a58d369d5c0b9`%0a    set WeatherDone%0a  end', 1557396911),
(8, 'right', '  script RightPanel%0a%0a  import div Container%0a%0a  div Inner%0a  div Block1%0a  img EditButton%0a  variable Content%0a  variable Mode%0a%0a  create Inner in Container%0a  set the style of Inner to `margin:5% 5%`%0a%0a  create EditButton in Inner%0a  set the style of EditButton to `width:25px;display:none`%0a  set attribute `src` of EditButton to `https://yorkshirewoman.uk/resources/system/edit.png`%0a  set attribute `title` of EditButton to `Edit the right sidebar article`%0a  on click EditButton send `editright` to parent%0a%0a  create Block1 in Inner%0a  set the style of Block1 to `padding-bottom:1em;border-bottom:1px solid lightgray;margin-bottom:1em`%0a%0a  on message go to Show%0a  set ready%0a  stop%0a%0aShow:%0a  get Mode from storage as `mode`%0a  if Mode is `admin` set style `display` of EditButton to `block`%0a  else set style `display` of EditButton to `none`%0a  rest get Content from `_/yw_articles/slug/right`%0a  or begin%0a    alert `Failed to get the content of the right panel.`%0a    stop%0a  end%0a  set the content of Block1 to decode property `article` of Content%0a', 1555602634),
(9, 'html-editor', '! The HTML editor%0a%0a  script HTMLEditor%0a%0a  input NameEditor%0a  button Open%0a  button Save%0a  button Delete%0a  a OpenID%0a  a NameLink%0a  div NameList%0a  div NameTemplate%0a  span Status%0a  variable List%0a  variable Name%0a  variable CurrentName %0a  variable Content%0a  variable Current%0a  variable N%0a  variable Count%0a  variable Names%0a%0a! The media browser%0a  div Overlay%0a  div Scroller%0a  div Media%0a  div FileListing%0a  div FileRow%0a  div Editor%0a  button CloseButton%0a  img Image%0a  a FileName%0a  variable Alpha%0a  variable Separator%0a  variable FileList%0a  variable FileCount%0a  variable File%0a  variable Type%0a%0a  attach Open to `ec-open`%0a  attach Save to `ec-save`%0a  attach Delete to `ec-delete`%0a  attach Status to `ec-status`%0a  attach NameEditor to `ec-name`%0a  put empty into Content%0a  attach Editor to `ec-content`%0a  ckeditor attach to Editor%0a  put empty into List%0a  put empty into Current%0a%0a  on click Save%0a  begin%0a    put the content of NameEditor into Name%0a    if Name is empty%0a    begin%0a      alert `No script name given.`%0a      stop%0a    end%0a    replace ` ` with `_` in Name%0a    ckeditor get Content from Editor%0a    if Content is not Current%0a    begin%0a      rest post Content to `ec_html/set/name/` cat Name%0a      put Content into Current%0a      set the content of Status to `Script ~sq~` cat Name cat `~sq~ saved`%0a      go to ResetStatus%0a    end%0a    else%0a    begin%0a      set the content of Status to `Nothing has changed`%0a      go to ResetStatus%0a    end%0a  end%0a%0a  on click Open go to DoOpen%0a%0a  on click Delete%0a  begin%0a    put the content of NameEditor into Name%0a    if Name is empty%0a    begin%0a      alert `Nothing to delete.`%0a      stop%0a    end%0a    if confirm `Are you sure you want to delete ~sq~` cat Name cat `~sq~?`%0a    begin%0a      rest post to `ec_html/delete/` cat Name%0a      set the content of Status to `Script ~sq~` cat Name cat `~sq~ deleted`%0a      set the content of NameEditor to empty%0a      put empty into Content%0a      ckeditor set Editor to Content%0a      put Content into Current%0a      go to ResetStatus%0a    end%0a  end%0a  stop%0a%0aDoOpen:%0a  ckeditor get Content from Editor%0a  if Content is not Current%0a  begin%0a    if confirm `Content has changed. Do you want to save it?`%0a    begin%0a      put the content of NameEditor into Name%0a      rest post Content to `ec_html/set/name/` cat Name%0a      set the content of Status to `Script ~sq~` cat Name cat `~sq~ saved`%0a      fork to ResetStatus%0a    end%0a  end%0a%0a  attach Overlay to `ec-overlay`%0a  set style `display` of Overlay to `block`%0a%0a! Animate the background%0a  put 0 into Alpha%0a  while Alpha is less than 8%0a  begin%0a    set style `background-color` of Overlay to `rgba(0,0,0,0.` cat Alpha cat `)`%0a    wait 4 ticks%0a    add 1 to Alpha%0a  end%0a  wait 20 ticks%0a%0a! Make the browser panel visible%0a  attach Media to `ec-media`%0a  set style `display` of Media to `inline-block`%0a  attach FileListing to `ec-file-listing`%0a  set style `display` of FileListing to `inline-block`%0a%0a! Fill the browser with content from the server%0a  rest get Content from `ec_html/names/0/1000`%0a  or begin%0a    alert `Failed to get the list of item names.`%0a    stop%0a  end%0a  put empty into FileList%0a  put the json count of Content into FileCount%0a  set the elements of File to FileCount%0a  set the elements of FileName to FileCount%0a! Add a row for each file%0a  put 0 into N%0a  while N is less than FileCount%0a  begin%0a    index File to N%0a    index FileName to N%0a    attach FileRow to `ec-file-row`%0a    put the content of FileRow into File%0a    replace `INDEX` with N in File%0a    if N is even replace `ODDEVEN` with `ec-even` in File%0a    else replace `ODDEVEN` with `ec-odd` in File%0a    put FileList cat File into FileList%0a    add 1 to N%0a  end%0a  attach Scroller to `ec-scroller`%0a  set the content of Scroller to FileList%0a! Add the document names%0a  put 0 into N%0a  while N is less than FileCount%0a  begin%0a    index File to N%0a    index FileName to N%0a    put element N of Content into File%0a    attach FileRow to `ec-file-row-` cat N%0a    attach FileName to `ec-file-name-` cat N%0a    set the content of FileName to File%0a    if N is even set style `background` of FileRow to `#eee`%0a    on click FileName go to SelectFile%0a    add 1 to N%0a  end%0a  attach CloseButton to `ec-close-media-button`%0a  on click CloseButton go to CloseBrowser%0a  stop%0a%0aSelectFile:%0a  index File to the index of FileName%0a  set the content of NameEditor to File%0a  rest get Content from `ec_html/name/` cat File%0a  or begin%0a    alert `Failed to get the file content.`%0a    stop%0a  end%0a  set the content of Status to `Script ~sq~` cat File cat `~sq~ loaded`%0a  fork to ResetStatus%0a  ckeditor set Editor to Content%0a  put Content into Current%0a%0aCloseBrowser:%0a  set style `background-color` of Overlay to `rgba(0,0,0,0.0)`%0a  set style `display` of Overlay to `none`%0a  set style `display` of Media to `none`%0a  stop%0a%0aResetStatus:%0a  wait 2%0a  set the content of Status to ``%0a  stop%0a', 1554733764),
(11, 'navigator', '  script Navigator%0a%0a  import div Container%0a    and variable CurrentPage%0a    and variable ArticleCount%0a%0a  div Navigator%0a  label PageLabel%0a  label PageNumber%0a  label Plus1%0a  label Plus10%0a  label Plus100%0a  label Minus1%0a  label Minus10%0a  label Minus100%0a  label Stats%0a  a PageLink%0a  a Plus1Link%0a  a Minus1Link%0a  variable NPages%0a  variable P%0a  variable N%0a  variable Message%0a%0a  create Navigator in Container%0a  set the style of Navigator to `margin:0.5em;text-align:center`%0a%0a  on message go to DoContent%0a  set ready%0a  stop%0a%0aDoContent:%0a  divide ArticleCount by 10 giving NPages%0a  if NPages is 0 put 1 into NPages%0a%0a  set the content of Navigator to ``%0a%0a  if CurrentPage is greater than 0%0a  begin%0a    create Minus1Link in Navigator%0a    create Minus1 in Minus1Link%0a    set the style of Minus1 to `padding:0 0.5em;font-weight:bold`%0a    set the content of Minus1 to `(-1)`%0a    on click Minus1%0a    begin%0a      put `` into Message%0a      set property `source` of Message to `Navigator`%0a      set property `action` of Message to `minus`%0a      set property `amount` of Message to 1%0a      send Message to parent%0a    end%0a  end%0a%0a  create PageLabel in Navigator%0a  set the text of PageLabel to `Page`%0a%0a  set the elements of PageLink to NPages%0a  set the elements of PageNumber to NPages%0a  take 5 from CurrentPage giving P%0a  if P is less than 0 put 0 into P%0a  take 10 from NPages giving N%0a  if N is less than 0 put 0 into P%0a  add 1 to P%0a  put 0 into N%0a  while N is less than NPages%0a  begin%0a    index PageLink to N%0a    index PageNumber to N%0a    if N is CurrentPage%0a    begin%0a      create PageNumber in Navigator%0a      set the style of PageNumber to `padding:0 0.25em;color:#800`%0a    end else begin%0a      create PageLink in Navigator%0a      create PageNumber in PageLink%0a      set the style of PageNumber to `padding:0 0.25em;font-weight:bold`%0a    end%0a    set the content of PageNumber to P%0a    on click PageNumber%0a    begin%0a      put `` into Message%0a      set property `source` of Message to `Navigator`%0a      set property `action` of Message to `page`%0a      set property `page` of Message to the index of PageNumber%0a      send Message to parent%0a    end%0a    add 1 to P%0a    add 1 to N%0a  end%0a  take CurrentPage from NPages giving N%0a  if N is greater than 1%0a  begin%0a    create Plus1Link in Navigator%0a    create Plus1 in Plus1Link%0a    set the style of Plus1 to `padding:0 0.5em;font-weight:bold`%0a    set the content of Plus1 to `(+1)`%0a    on click Plus1%0a    begin%0a      put `` into Message%0a      set property `source` of Message to `Navigator`%0a      set property `action` of Message to `plus`%0a      set property `amount` of Message to 1%0a      send Message to parent%0a    end%0a  end%0a  create Stats in Navigator%0a  set the content of Stats to ` ` cat ArticleCount cat ` articles`%0a  stop', 1558006594),
(12, 'viewer', '! Article viewer%0a%0a  script ArticleViewer%0a%0a  import%0a    div Parent%0a    and variable Record%0a    and variable Mode%0a    and variable Message%0a%0a  div Container%0a  div ArticleDiv%0a  div FooterDiv%0a  div SectionDiv%0a  div AuthorDiv%0a  div TagsDiv%0a  div CopyrightDiv%0a  h2 TitleHeader%0a  h5 SectionHeader%0a  img EditButton%0a  a SectionLink%0a  a AuthorLink%0a  a TagLink%0a  span Span%0a  variable Password%0a  variable Title%0a  variable Section%0a  variable Author%0a  variable Valid%0a  variable ID%0a  variable Tags%0a  variable Count%0a  variable N%0a  variable Tag%0a  variable CopyrightFormat%0a  variable Content%0a  variable User%0a%0a  create Container in Parent%0a%0a  on message go to ShowArticle%0a  set ready%0a  stop%0a%0aShowArticle:%0a  set the content of Container to ``%0a  if Mode is `admin`%0a  begin%0a    create EditButton in Container%0a    set the style of EditButton to `float:right;width:25px;margin-top:0.25em`%0a    set attribute `src` of EditButton to `https://yorkshirewoman.uk/resources/system/edit.png`%0a    on click EditButton%0a    begin%0a      put `edit` into Message%0a      history back%0a    end%0a  end%0a%0a  put property `section` of Record into Section%0a  put property `author` of Record into Author%0a  put property `tags` of Record into Tags%0a%0a  create SectionHeader in Container%0a  set the style of SectionHeader to `color:#f08`%0a  set the content of SectionHeader to property `section` of Record%0a%0a  put decode property `title` of Record into Title%0a  create TitleHeader in Container%0a  set the style of TitleHeader to `color:#428bca;margin-bottom:1em`%0a%0a  set the content of TitleHeader to Title%0a%0a  create ArticleDiv in Container%0a  set style `margin-top` of ArticleDiv to `0.5em`%0a  set the content of ArticleDiv to decode property `article` of Record%0a%0a  create FooterDiv in Container%0a  set style of FooterDiv to%0a    `margin:0.5em 0;border-top:1px solid gray`%0a  if Section%0a  begin%0a    create SectionDiv in FooterDiv%0a    set style of SectionDiv to%0a      `margin:0.5em 0;font-size:85%;font-weight:bold;color:red`%0a  end%0a  if Author%0a  begin%0a    create AuthorDiv in FooterDiv%0a    set style of AuthorDiv to%0a      `margin:0.5em 0;font-size:85%;font-weight:bold;color:blue`%0a  end%0a  if Tags%0a  begin%0a    create TagsDiv in FooterDiv%0a    set style of TagsDiv to%0a      `margin:0.5em 0;font-size:85%;font-weight:bold;color:green`%0a  end%0a%0a  put property `id` of Record into ID%0a%0a  if Section%0a  begin%0a    create Span in SectionDiv%0a    set the content of Span to `Section: `%0a    create SectionLink in SectionDiv%0a    set style `margin` of SectionLink to `0 0.25em`%0a    set the content of SectionLink to Section%0a    on click SectionLink%0a    begin%0a      put `{}` into Message%0a      set property `source` of Message to `Viewer`%0a      set property `action` of Message to `section`%0a      replace ` ` with `%20` in Section%0a      set property `name` of Message to Section%0a      history back%0a    end%0a  end%0a%0a  if Author%0a  begin%0a    create Span in AuthorDiv%0a    set the content of Span to `Author: `%0a    create AuthorLink in AuthorDiv%0a    set style `margin` of AuthorLink to `0 0.25em`%0a    set the content of AuthorLink to Author%0a    on click AuthorLink%0a    begin%0a      put `{}` into Message%0a      set property `source` of Message to `Viewer`%0a      set property `action` of Message to `author`%0a      replace ` ` with `%20` in Author%0a      set property `name` of Message to Author%0a      history back%0a    end%0a  end%0a%0a  if Tags%0a  begin%0a    create Span in TagsDiv%0a    set the content of Span to `Tags: `%0a    rest get Tags from `_/yw_tags/tags/` cat ID%0a    or begin%0a      alert `Failed to read the article tags.`%0a      stop%0a    end%0a    put the json count of Tags into Count%0a    set the elements of TagLink to Count%0a    put 0 into N%0a    while N is less than Count%0a    begin%0a      index TagLink to N%0a      create TagLink in TagsDiv%0a      set style `margin` of TagLink to `0 0.25em`%0a      set the content of TagLink to element N of Tags%0a      on click TagLink%0a      begin%0a        put the content of TagLink into Tag%0a        put `{}` into Message%0a        set property `source` of Message to `Viewer`%0a        set property `action` of Message to `tag`%0a        set property `tag` of Message to Tag%0a        history back%0a      end%0a      add 1 to N%0a    end%0a  end%0a%0a  history push url `?` cat property `slug` of Record%0a%0a!  put empty into Content%0a!  set property `action` of Content to `view`%0a!  set property `slug` of Content to property `slug` of Record%0a!  get User from storage as `user`%0a!  rest post Content to `_/ec-tracking/tracking/` cat User or stop%0a%0a  on close set style `display` of Container to `none`%0a%0a  set style `display` of Container to `block`%0a  if mobile scroll to 1%0a%0a  stop', 1558005984),
(13, 'editor', '! Article editor%0a%0a  script ArticleEditor%0a%0a  import%0a    div Body%0a    and div Container%0a    and variable Record%0a    and variable Message%0a%0a  div EditorDiv%0a  div DateHolder%0a  div SelectorButtons%0a  div PublishedDiv%0a  div IDDiv%0a  div SlugDiv%0a  div EditionDiv%0a  div SectionDiv%0a  div AuthorDiv%0a  div TitleDiv%0a  div TagsDiv%0a  div SynopsisDiv%0a  div ArticleDiv%0a  div Buttons%0a  div Block1%0a  span Status%0a  label PublishedLabel%0a  label IDLabel%0a  label IDText%0a  label SlugLabel%0a  label EditionLabel%0a  label SectionLabel%0a  label AuthorLabel%0a  label TitleLabel%0a  label TagsLabel%0a  button SynopsisButton%0a  button ArticleButton%0a  img FolderIcon%0a  img SaveIcon%0a  img ViewIcon%0a  module FileManager%0a  input PublicCheckbox%0a  input SlugInput%0a  input EditionInput%0a  input SectionInput%0a  input AuthorInput%0a  input TitleInput%0a  input TagsInput%0a  date Date%0a  variable ID%0a  variable Slug%0a  variable Published%0a  variable Public%0a  variable Edition%0a  variable Section%0a  variable Author%0a  variable Title%0a  variable Tags%0a  variable Synopsis%0a  variable Article%0a  variable OriginalSynopsis%0a  variable OriginalArticle%0a  variable FileManagerRunning%0a  variable Script%0a  variable TextBoxWidth%0a  variable Content%0a%0a  create EditorDiv in Container%0a  set the style of EditorDiv to `display:none;width:100%`%0a%0a  create Buttons in EditorDiv%0a  set the style of Buttons to `float:right;text-align:right`%0a%0a  create Status in Buttons%0a  set the style of Status to `color:green;padding-right:1em;margin-bottom:1em`%0a  create FolderIcon in Buttons%0a  set the style of FolderIcon to `width:25px;margin-right:10px`%0a  set attribute `src` of FolderIcon to `https://yorkshirewoman.uk/resources/system/media.png`%0a  set attribute `title` of FolderIcon to `Media manager`%0a  on click FolderIcon go to FileMan%0a  create SaveIcon in Buttons%0a  set the style of SaveIcon to `width:25px;margin-right:10px`%0a  set attribute `src` of SaveIcon to `https://yorkshirewoman.uk/resources/system/save.png`%0a  set attribute `title` of SaveIcon to `Save changes`%0a  on click SaveIcon go to Save%0a  create ViewIcon in Buttons%0a  set the style of ViewIcon to `width:25px;margin-right:10px`%0a  set attribute `src` of ViewIcon to `https://yorkshirewoman.uk/resources/system/binoculars.png`%0a  set attribute `title` of ViewIcon to `View article without saving`%0a  on click ViewIcon go to View%0a%0a  create Block1 in EditorDiv%0a%0a  create PublishedDiv in Block1%0a  set style `display` of PublishedDiv to `flex`%0a  create PublishedLabel in PublishedDiv%0a  set the style of PublishedLabel to `width:7em`%0a  set the content of PublishedLabel to `Published:`%0a  create DateHolder in PublishedDiv%0a  set style `margin-bottom` of DateHolder to `0.5em`%0a  create Date in DateHolder%0a  create PublicCheckbox in DateHolder%0a  set style `margin-left` of PublicCheckbox to `3em`%0a  set attribute `type` of PublicCheckbox to `checkbox`%0a  put 40 into TextBoxWidth%0a%0a  create IDDiv in Block1%0a  set style `display` of IDDiv to `flex`%0a  create IDLabel in IDDiv%0a  set the style of IDLabel to `width:7em`%0a  set the content of IDLabel to `ID:`%0a  create IDText in IDDiv%0a%0a  create SlugDiv in Block1%0a  set style `display` of SlugDiv to `flex`%0a  create SlugLabel in SlugDiv%0a  set the style of SlugLabel to `width:7em`%0a  set the content of SlugLabel to `SEO&nbsp;Slug:`%0a  create SlugInput in SlugDiv%0a  set the size of SlugInput to TextBoxWidth%0a%0a  create EditionDiv in Block1%0a  set style `display` of EditionDiv to `flex`%0a  create EditionLabel in EditionDiv%0a  set the style of EditionLabel to `width:7em`%0a  set the content of EditionLabel to `Edition:`%0a  create EditionInput in EditionDiv%0a  set the size of EditionInput to TextBoxWidth%0a%0a  create SectionDiv in Block1%0a  set style `display` of SectionDiv to `flex`%0a  create SectionLabel in SectionDiv%0a  set the style of SectionLabel to `width:7em`%0a  set the content of SectionLabel to `Section:`%0a  create SectionInput in SectionDiv%0a  set the size of SectionInput to TextBoxWidth%0a%0a  create AuthorDiv in Block1%0a  set style `display` of AuthorDiv to `flex`%0a  create AuthorLabel in AuthorDiv%0a  set the style of AuthorLabel to `width:7em`%0a  set the content of AuthorLabel to `Author:`%0a  create AuthorInput in AuthorDiv%0a  set the size of AuthorInput to TextBoxWidth%0a%0a  create TitleDiv in Block1%0a  set style `display` of TitleDiv to `flex`%0a  create TitleLabel in TitleDiv%0a  set the style of TitleLabel to `width:7em`%0a  set the content of TitleLabel to `Title:`%0a  create TitleInput in TitleDiv%0a  set the size of TitleInput to TextBoxWidth%0a%0a  create TagsDiv in Block1%0a  set style `display` of TagsDiv to `flex`%0a  create TagsLabel in TagsDiv%0a  set the style of TagsLabel to `width:7em`%0a  set the content of TagsLabel to `Tags:`%0a  create TagsInput in TagsDiv%0a  set the size of TagsInput to TextBoxWidth%0a%0a  create SelectorButtons in EditorDiv%0a  set the style of SelectorButtons to `width:100%;text-align:center`%0a  create SynopsisButton in SelectorButtons%0a  set the style of SynopsisButton to `width:50%;background:darkgray`%0a  set the text of SynopsisButton to `Synopsis`%0a  create ArticleButton in SelectorButtons%0a  set the style of ArticleButton to `width:50%`%0a  set the text of ArticleButton to `Article`%0a  on click SynopsisButton%0a  begin%0a    set style `display` of SynopsisDiv to `block`%0a    set style `display` of ArticleDiv to `none`%0a    set style `background` of SynopsisButton to `darkgray`%0a    set style `background` of ArticleButton to ``%0a  end%0a  on click ArticleButton%0a  begin%0a    set style `display` of SynopsisDiv to `none`%0a    set style `display` of ArticleDiv to `block`%0a    set style `background` of SynopsisButton to ``%0a    set style `background` of ArticleButton to `darkgray`%0a  end%0a%0a  create SynopsisDiv in EditorDiv%0a  set the style of SynopsisDiv to `width:100%`%0a  ckeditor attach to SynopsisDiv%0a%0a  create ArticleDiv in EditorDiv%0a  set the style of ArticleDiv to `width:100%;margin-bottom:500px`%0a  ckeditor attach to ArticleDiv%0a%0a  on message go to Editor%0a  set ready%0a  stop%0a%0aEditor:%0a  set style `display` of EditorDiv to `block`%0a  set style `display` of ArticleDiv to `none`%0a%0a  history push%0a  put property `published` of Record into Published%0a  put property `public` of Record into Public%0a  put property `id` of Record into ID%0a  put property `slug` of Record into Slug%0a  put property `edition` of Record into Edition%0a  put property `section` of Record into Section%0a  put property `author` of Record into Author%0a  put decode property `title` of Record into Title%0a  put property `tags` of Record into Tags%0a  put decode property `synopsis` of Record into Synopsis%0a  put decode property `article` of Record into Article%0a  put Synopsis into OriginalSynopsis%0a  put Article into OriginalArticle%0a  on close%0a  begin%0a    set style `display` of EditorDiv to `none`%0a  end%0a%0a  if Synopsis is empty%0a  begin%0a    alert `Synopsis is empty - cancelling this edit`%0a    history back%0a    stop%0a  end%0a  if Article is empty%0a  begin%0a    alert `Article is empty - cancelling this edit`%0a    history back%0a    stop%0a  end%0a%0a  set the date of Date to Published%0a  if Public set attribute `checked` of PublicCheckbox%0a  else remove attribute `checked` of PublicCheckbox%0a  set the content of IDText to ID%0a  set the content of SlugInput to Slug%0a  set the content of EditionInput to Edition%0a  set the content of SectionInput to Section%0a  set the content of AuthorInput to Author%0a  set the content of TitleInput to Title%0a  set the content of TagsInput to Tags%0a  wait 50 ticks%0a  ckeditor set SynopsisDiv to Synopsis%0a  wait 50 ticks%0a  ckeditor set ArticleDiv to Article%0a%0a! Check the editors set up properly%0a  wait 50 ticks%0a  ckeditor get Content from SynopsisDiv%0a  if Content is empty%0a  begin%0a    alert `Synopsis editor did not initialise correctly - please try again`%0a    history back%0a    stop%0a  end%0a  ckeditor get Content from ArticleDiv%0a  if Content is empty%0a  begin%0a    alert `Article editor did not initialise correctly - please try again`%0a    history back%0a    stop%0a  end%0a  scroll to 0%0a  stop%0a%0aSave:%0a  put Date into Published%0a  put attribute `checked` of PublicCheckbox into Public%0a  put the text of EditionInput into Edition%0a  put the text of SectionInput into Section%0a  put the text of AuthorInput into Author%0a  put the text of TitleInput into Title%0a  put the text of TagsInput into Tags%0a  ckeditor get Synopsis from SynopsisDiv%0a  ckeditor get Article from ArticleDiv%0a  put lowercase the text of SlugInput into Slug%0a  if Slug is empty put lowercase Title into Slug%0a  replace ` ` with `-` in Slug%0a  replace `~sq~` with `` in Slug%0a  replace `~dq~` with `` in Slug%0a  replace `~sq~` with `` in Tags%0a  replace `~dq~` with `` in Tags%0a%0a  if Synopsis is empty%0a  begin%0a    if OriginalSynopsis is not empty%0a    begin%0a      alert `Synopsis must not be empty`%0a      stop%0a    end%0a  end%0a  if Article is empty%0a  begin%0a    if OriginalArticle is not empty%0a    begin%0a      alert `Article must not be empty`%0a      stop%0a    end%0a  end%0a  if Slug is numeric%0a  begin%0a    alert `SEO Slug must not be numeric`%0a    stop%0a  end%0a%0a  put `{}` into Record%0a  set property `id` of Record to ID%0a  set property `published` of Record to Published%0a  set property `public` of Record to Public%0a  set property `slug` of Record to Slug%0a  set property `edition` of Record to Edition%0a  set property `section` of Record to Section%0a  set property `author` of Record to Author%0a  set property `title` of Record to encode Title%0a  set property `tags` of Record to lowercase Tags%0a  set property `synopsis` of Record to encode Synopsis%0a  set property `article` of Record to encode Article%0a  rest post Record to `_/yw_articles/update/` cat ID%0a  or begin%0a    set the content of Status to `Failed to save article`%0a    stop%0a  end%0a%0a  set the content of Status to `Article saved`%0a  wait 3%0a  set the content of Status to ``%0a  stop%0a%0aView:%0a  put `show` into Message%0a  history back%0a  stop%0a%0aFileMan:%0a  if not FileManagerRunning%0a  begin:%0a    rest get Script from `ec_scripts/name/fileman`%0a    or begin%0a      set the content of Status to `Failed to load article`%0a    end%0a    run Script with Body as FileManager%0a    set FileManagerRunning%0a  end%0a  history set%0a  on restore%0a  begin%0a    close FileManager%0a  end%0a%0a  send to FileManager%0a  stop%0a', 1554308380),
(14, 'menu', '  script Menu%0a%0a  import div Header%0a%0a  div MenuDiv%0a  div Mask%0a  div Panel%0a  div SectionsLabel%0a  div SectionsDiv%0a  div SectionDiv%0a  div AuthorsLabel%0a  div AuthorsDiv%0a  div AuthorDiv%0a  a SectionLink%0a  a AuthorLink%0a  button HomeButton%0a  button AboutButton%0a  button MenuButton%0a  button FacebookButton%0a  variable Style%0a  variable Message%0a  variable Alpha%0a  variable Sections%0a  variable Section%0a  variable Authors%0a  variable Author%0a  variable Name%0a  variable Count%0a  variable N%0a%0a  create MenuDiv in Header%0a  if mobile set the style of MenuDiv to%0a    `display:flex;width:100%;margin:0 auto auto;text-align:center`%0a  else set the style of MenuDiv to%0a    `display:flex;width:680px;margin:0 auto;text-align:center`%0a%0a  put `flex:25;background:#444;color:white;font-weight:bold` into Style%0a  create HomeButton in MenuDiv%0a  set the style of HomeButton to Style%0a  set style `color` of HomeButton to `gray`%0a  set the text of HomeButton to `Home`%0a  on click HomeButton send `homebutton` to parent%0a  create AboutButton in MenuDiv%0a  set the style of AboutButton to Style%0a  set the text of AboutButton to `About`%0a  on click AboutButton send `aboutbutton` to parent%0a  create FacebookButton in MenuDiv%0a  set the style of FacebookButton to Style%0a  set the text of FacebookButton to `Facebook`%0a  on click FacebookButton location `https://facebook.com/YorkshireWomanPage`%0a  create MenuButton in MenuDiv%0a  set the style of MenuButton to Style%0a  set the text of MenuButton to `Menu`%0a  on click MenuButton go to SiteMap%0a%0a  on message%0a  begin%0a    put the message into Message%0a    if property `button` of Message is `home`%0a    begin%0a      if property `action` of Message is `enable`%0a        set style `color` of HomeButton to `white`%0a      else if property `action` of Message is `disable`%0a        set style `color` of HomeButton to `gray`%0a    end%0a    else if property `button` of Message is `about`%0a    begin%0a      if property `action` of Message is `enable`%0a        set style `color` of AboutButton to `white`%0a      else if property `action` of Message is `disable`%0a        set style `color` of AboutButton to `gray`%0a    end%0a    else if property `button` of Message is `menu`%0a    begin%0a      if property `action` of Message is `enable`%0a        set style `color` of MenuButton to `white`%0a      else if property `action` of Message is `disable`%0a        set style `color` of MenuButton to `gray`%0a    end%0a  end%0a%0a  create Mask%0a  set the style of Mask to `display:none;position:absolute;top:0;left:0;right:0;bottom:0;`%0a    cat `width:100%;height:100%;z-index:5;background-color:rgba(0,0,0,0.0);text-align:center`%0a%0a  set ready%0a  stop%0a%0aSiteMap:%0a  send `menubutton` to parent%0a  set style `display` of Mask to `block`%0a%0a  create Panel in Mask%0a  if mobile%0a    set the style of Panel to%0a      `width:100%;height:100%;background:#ffe;text-align:left`%0a  else%0a    set the style of Panel to%0a      `width:50vw;height:75vh;margin-top:15vh;margin-left:25vw;background:#ffe;`%0a      cat `text-align:left;border:3px solid black;padding:1em;display:flex`%0a%0a  put 0 into Alpha%0a  while Alpha is less than 8%0a  begin%0a    set style `background-color` of Mask to `rgba(0,0,0,0.` cat Alpha cat `)`%0a    wait 4 ticks%0a    add 1 to Alpha%0a  end%0a%0a  on click Panel go to Close%0a%0a  create SectionsDiv in Panel%0a  on click SectionsDiv go to Close%0a  set the style of SectionsDiv to `flex:50`%0a  create SectionsLabel in SectionsDiv%0a  set the style of SectionsLabel to `font-weight:bold;margin-bottom:0.7em`%0a  set the content of SectionsLabel to `Sections:`%0a  rest get Sections from `_/yw_sections/enum`%0a  put the json count of Sections into Count%0a  set the elements of SectionDiv to Count%0a  set the elements of SectionLink to Count%0a  set the elements of Section to Count%0a  put 0 into N%0a  while N is less than Count%0a  begin%0a    index SectionDiv to N%0a    index SectionLink to N%0a    index Section to N%0a    create SectionDiv in SectionsDiv%0a    create SectionLink in SectionDiv%0a    put element N of Sections into Section%0a    put Section into Name%0a    replace `%20` with ` ` in Name%0a    set the content of SectionLink to Name%0a    on click SectionLink%0a    begin%0a      put `` into Message%0a      set property `source` of Message to `Menu`%0a      set property `selector` of Message to `section`%0a      index Section to the index of SectionLink%0a      set property `section` of Message to Section%0a      send Message to parent%0a      gosub to Close%0a    end%0a    add 1 to N%0a  end%0a%0a  create AuthorsDiv in Panel%0a  on click AuthorsDiv go to Close%0a  set the style of AuthorsDiv to `flex:50`%0a  create AuthorsLabel in AuthorsDiv%0a  set the style of AuthorsLabel to `font-weight:bold;margin-bottom:0.7em`%0a  set the content of AuthorsLabel to `Authors:`%0a  rest get Authors from `_/yw_authors/enum`%0a  put the json count of Authors into Count%0a  set the elements of AuthorDiv to Count%0a  set the elements of AuthorLink to Count%0a  set the elements of Author to Count%0a  put 0 into N%0a  while N is less than Count%0a  begin%0a    index AuthorDiv to N%0a    index AuthorLink to N%0a    index Author to N%0a    create AuthorDiv in AuthorsDiv%0a    create AuthorLink in AuthorDiv%0a    put element N of Authors into Author%0a    put Author into Name%0a    replace `%20` with ` ` in Name%0a    set the content of AuthorLink to Name%0a    on click AuthorLink%0a    begin%0a      put `` into Message%0a      set property `source` of Message to `Menu`%0a      set property `selector` of Message to `author`%0a      index Author to the index of AuthorLink%0a      set property `author` of Message to Author%0a      send Message to parent%0a      gosub to Close%0a    end%0a    add 1 to N%0a  end%0a  stop%0a%0aClose:%0a  clear Mask%0a  set style `background-color` of Mask to `rgba(0,0,0,0.0)`%0a  set style `display` of Mask to `none`%0a  stop', 1559768081);
INSERT INTO `ec_scripts` (`id`, `name`, `value`, `ts`) VALUES
(16, 'yorkshirewoman', '  script Yorkshirewoman%0a%0a  div Block%0a  h5 SectionText%0a  div SynopsisText%0a  div SynopsisGroup%0a  div DateGroup%0a  div Body%0a  div Header%0a  div BannerDiv%0a  div Buttons%0a  div ContentDiv%0a  div NavigatorDiv%0a  div CopyrightDiv%0a  div Columns%0a  div LeftColumn%0a  div CenterColumn%0a  div RightColumn%0a  div Blocks%0a  div Div%0a  span Span%0a  a TitleLink%0a  a SectionLink%0a  h5 SelectorDiv%0a  img EditButton%0a  img NewButton%0a  img ToolsButton%0a  img BannerImage%0a  module LeftPanel%0a  module RightPanel%0a  module Menu%0a  module Navigator%0a  module ArticleViewer%0a  module ArticleEditor%0a  variable Visitor%0a  variable NClicks%0a  variable Valid%0a  variable Password%0a  variable Mode%0a  variable Articles%0a  variable Article%0a  variable DisplayCount%0a  variable ArticleCount%0a  variable CurrentPage%0a  variable ArticleViewerRunning%0a  variable ArticleEditorRunning%0a  variable MenuRunning%0a  variable Record%0a  variable Script%0a  variable LeftScript%0a  variable RightScript%0a  variable NavigatorScript%0a  variable Location%0a  variable Content%0a  variable Args%0a  variable Item%0a  variable Name%0a  variable Slug%0a  variable Published%0a  variable HistoryState%0a  variable Index%0a  variable N%0a  variable Message%0a  variable ViewerMessage%0a  variable ButtonMessage%0a  variable TrackingMessage%0a  variable All%0a  variable Action%0a  variable Selector%0a  variable Tag%0a  variable Author%0a  variable Section%0a  variable DateFormat%0a  variable CopyrightFormat%0a  variable ScrollPosition%0a%0a! Parse the URL%0a  json parse url the location as Args%0a  put property `arg` of Args into Slug%0a  if Slug is empty put `` into Slug%0a%0a! Basic information & set up%0a  get Visitor from storage as `visitor`%0a  rest post to `_/ec_visits/log/` cat Visitor giving Visitor%0a    or print `Could not get visitor id`%0a  put Visitor into storage as `visitor`%0a%0a  get Mode from storage as `mode`%0a  put `` into Selector%0a  put 0 into CurrentPage%0a  set the title to `Yorkshirewoman`%0a%0a  put empty into DateFormat%0a  set property `mode` of DateFormat to `date`%0a  set property `locale` of DateFormat to `en-EN`%0a  put empty into Content%0a  set property `weekday` of Content to `long`%0a  set property `year` of Content to `numeric`%0a  set property `month` of Content to `long`%0a  set property `day` of Content to `numeric`%0a  set property `options` of DateFormat to Content%0a%0a  put empty into CopyrightFormat%0a  set property `mode` of CopyrightFormat to `date`%0a  set property `locale` of CopyrightFormat to `en-EN`%0a  put empty into Content%0a  set property `year` of Content to `numeric`%0a  set property `options` of CopyrightFormat to Content%0a%0a  attach Body to `ec-body`%0a  gosub to SetupScreen%0a%0a  if Slug%0a  begin%0a    gosub to ViewSlug%0a    gosub to DoFooter%0a  end%0a%0a! Deal with mode changes%0a  put 0 into NClicks%0a  if mobile%0a  begin%0a    on click BannerImage%0a    begin%0a      if Mode is `admin` go to SetUserMode%0a      add 1 to NClicks%0a      if NClicks is 3 go to SetAdminMode%0a    end%0a  end%0a  else begin  %0a    on key%0a    begin%0a      if Location is not `home` stop%0a      if the key is `a`%0a      begin%0a        add 1 to NClicks%0a        if NClicks is 3 go to SetAdminMode%0a      end%0a      else%0a      begin%0a        if the key is `u` go to SetUserMode%0a        if the key is `o` go to Logout%0a        put 0 into NClicks%0a      end%0a    end%0a  end%0a%0a! Handle clicks on links%0a  on click document%0a  begin%0a    put the parent name into Name%0a    if Name is `SynopsisText`%0a    begin%0a      put the parent index into Index%0a      put element Index of Articles into Article%0a      gosub to TrackArticle%0a    end%0a  end%0a%0a  on message%0a  begin%0a    put the message into Message%0a    if Message is `editleft`%0a    begin%0a      put `left` into Slug%0a      go to EditSlug%0a    end%0a    if Message is `editright`%0a    begin%0a      put `right` into Slug%0a      go to EditSlug%0a    end%0a    else if Message is `homebutton`%0a    begin%0a      if Location is not `home`%0a      begin%0a        gosub to DisableHomeButton%0a        history back%0a      end%0a      else if Selector%0a      begin%0a        put `` into Selector%0a        gosub to DisableHomeButton%0a        put 0 into CurrentPage%0a        gosub to RedrawBlocks%0a      end%0a      else if CurrentPage is not 0%0a      begin%0a        gosub to DisableHomeButton%0a        put 0 into CurrentPage%0a        gosub to RedrawBlocks%0a      end%0a    end%0a    else if Message is `aboutbutton`%0a    begin%0a      if Location is `edit` stop%0a      if Location is `show`%0a      begin%0a        put `about` into Slug%0a        put `show` into ViewerMessage%0a        history back%0a      end%0a      if Location is `home`%0a      begin%0a        put `about` into Slug%0a        gosub to ViewSlug%0a        gosub to DoFooter%0a      end%0a    end%0a    else if Message is `menubutton`%0a    begin%0a      if Location is `edit` stop%0a      if Location is `show` history back%0a    end%0a    else%0a    begin%0a      put property `source` of Message into Item%0a      if Item is `Navigator`%0a      begin%0a        put property `action` of Message into Action%0a        if Action is `page`%0a        begin%0a          put property `page` of Message into CurrentPage%0a        end%0a        else if Action is `plus`%0a        begin%0a          add property `amount` of Message to CurrentPage%0a        end%0a        else if Action is `minus`%0a        begin%0a          take property `amount` of Message from CurrentPage%0a        end%0a        if CurrentPage is not 0 gosub to EnableHomeButton%0a        gosub to RedrawBlocks%0a        send to Navigator%0a      end%0a      else if Item is `Menu~sq~%0a      begin%0a        put property `selector` of Message into Selector%0a        if Selector is `section` put property `section` of Message into Section%0a        if Selector is `author` put property `author` of Message into Author%0a        put 0 into CurrentPage%0a        gosub to RedrawBlocks%0a        gosub to EnableHomeButton%0a      end%0a    end%0a  end%0a  on leave%0a  begin%0a    put `` into TrackingMessage%0a    set property `event` of TrackingMessage to `leave`%0a    gosub to Tracking%0a  end%0a%0a  wait 10 ticks%0a  rest get LeftScript from `ec_scripts/name/left`%0a  or alert `Unable to load the left panel script - please restart.`%0a  run LeftScript with LeftColumn and Message as LeftPanel%0a  rest get RightScript from `ec_scripts/name/right`%0a  or alert `Unable to load the right panel script - please restart.`%0a  run RightScript with RightColumn as RightPanel%0a  rest get NavigatorScript from `ec_scripts/name/navigator`%0a  or alert `Unable to load the navigator script - please restart.`%0a  run NavigatorScript with NavigatorDiv and CurrentPage and ArticleCount as Navigator%0a  send to LeftPanel%0a  send to RightPanel%0a  send to Navigator%0a  stop%0a%0aSetAdminMode:%0a  get Password from storage as `password`%0a  if Password is empty%0a    put prompt `Please type the admin password` with `` into Password%0a  rest get Valid from `_verify/` cat Password%0a  or alert `Unable to verify password - please try again.`%0a  if Valid is `yes`%0a  begin%0a    put Password into storage as `password`%0a    put `admin` into storage as `mode`%0a    put `admin` into Mode%0a    go to ShowAdminControls%0a  end%0a  put 0 into NClicks%0a  stop%0a%0aShowAdminControls:%0a  gosub to RedrawBlocks%0a  set style `display` of NewButton to `inline-block`%0a  set attribute `title` of NewButton to `New article`%0a  set style `display` of ToolsButton to `inline-block`%0a  set attribute `title` of ToolsButton to `Admin tools`%0a  put 0 into N%0a  while N is less than DisplayCount%0a  begin%0a    index EditButton to N%0a    set style `display` of EditButton to `inline-block`%0a    set attribute `title` of EditButton to `Edit this article`%0a    add 1 to N%0a  end%0a  send to LeftPanel%0a  send to RightPanel%0a  put 0 into NClicks%0a  stop%0a%0aLogout:%0a  put `` into storage as `password`%0aSetUserMode:%0a  put `` into storage as `mode`%0a  put `user` into Mode%0a  gosub to RedrawBlocks%0a  set style `display` of NewButton to `none`%0a  set style `display` of ToolsButton to `none`%0a  put 0 into N%0a  while N is less than DisplayCount%0a  begin%0a    index EditButton to N%0a    set style `display` of EditButton to `none`%0a    add 1 to N%0a  end%0a  send to LeftPanel%0a  send to RightPanel%0a  put 0 into NClicks%0a  stop%0a%0aSetupScreen:%0a  put `home` into Location%0a  put `` into Message%0a  if portrait%0a  begin%0a    if mobile%0a      set the style of Body to `position:absolute;margin:0;width:100%;height:100vh`%0a    else set the style of Body to `width:100%`%0a  end%0a  else%0a  begin%0a    if mobile%0a      set the style of Body to `position:absolute;margin:0;width:100%;height:100vh`%0a    else set the style of Body to `width:1200px;margin:0 auto`%0a  end%0a  set the content of Body to ``%0a  create Header in Body%0a  set the style of Header to `text-align:center`%0a%0a  create BannerDiv in Header%0a  set the style of BannerDiv to%0a    `position:relative;padding-bottom:1em;border-bottom:1px solid #ccc`%0a%0a  create Buttons in BannerDiv%0a  set the style of Buttons to `position:absolute;right:0`%0a  create NewButton in Buttons%0a  set the style of NewButton to `display:none;width:25px;margin-top:0.5em;`%0a  set attribute `src` of NewButton to `https://yorkshirewoman.uk/resources/system/new.png`%0a  set attribute `title` of NewButton to `New article`%0a  on click NewButton%0a  begin%0a    put `` into Record%0a    set property `published` of Record to now%0a    set property `slug` of Record to ``%0a    set property `edition` of Record to ``%0a    set property `title` of Record to `Title`%0a    set property `section` of Record to ``%0a    set property `author` of Record to ``%0a    set property `tags` of Record to ``%0a    set property `synopsis` of Record to `Synopsis text`%0a    set property `article` of Record to `Main article text`%0a    rest post Record to `_/yw_articles/new/`%0a    or alert `Unable to create new record - please try again.`%0a    gosub to RedrawBlocks%0a  end%0a  create ToolsButton in Buttons%0a  set the style of ToolsButton to `display:none;width:25px;margin-top:0.5em;`%0a  set attribute `src` of ToolsButton to `https://yorkshirewoman.uk/resources/system/gear.png`%0a  set attribute `title` of ToolsButton to `Admin tools`%0a  on click ToolsButton location new `https://yorkshirewoman.uk/admin`%0a%0a  create BannerImage in BannerDiv%0a  if portrait%0a  begin%0a    set the style of BannerImage to `width:100%;margin-top:10px`%0a    set attribute `src` of BannerImage to%0a      `https://yorkshirewoman.uk/resources/system/YWLogo-m.png`%0a  end else begin%0a    if mobile  set the style of BannerImage to `width:60%;margin-top:10px`%0a    else set the style of BannerImage to `width:860px;margin-top:10px`%0a    set attribute `src` of BannerImage to%0a      `https://yorkshirewoman.uk/resources/system/YWLogo.png`%0a  end%0a%0a  if not MenuRunning%0a  begin%0a    rest get Script from `ec_scripts/name/menu`%0a    or begin%0a      alert `Unable to get the menu script - please try again.`%0a      stop%0a    end%0a    run Script with Header as Menu%0a    set MenuRunning%0a  end%0a%0a  if Mode is `admin`%0a  begin%0a    set style `display` of NewButton to `inline-block`%0a    set style `display` of ToolsButton to `inline-block`%0a  end%0a%0a  create ContentDiv in Body%0a  create Columns in ContentDiv%0a  if portrait set the style of Columns to `width:100%`%0a  else set the style of Columns to `display:flex`%0a%0a  create LeftColumn in Columns%0a  create CenterColumn in Columns%0a  create RightColumn in Columns%0a  if portrait%0a  begin%0a    set the style of LeftColumn to `display:none`%0a    set the style of CenterColumn to%0a      `position:absolute;top:110px;left:0;right:0;bottom:0;margin:0 0.5em;overflow:scroll` %0a    set the style of RightColumn to `display:none`%0a  end%0a  else%0a  begin%0a    set the style of LeftColumn to `flex:250`%0a    set the style of CenterColumn to `flex:700;margin:0 20px`%0a    set the style of RightColumn to `flex:250`%0a  end%0a  if mobile%0a  begin%0a    if Mode is `admin`%0a    begin%0a      create Div in CenterColumn%0a      set the style of Div to `height:1em`%0a    end%0a  end%0a  create Blocks in CenterColumn%0a%0a  create NavigatorDiv in CenterColumn%0a  create CopyrightDiv in ContentDiv%0a%0aRedrawBlocks:%0a  if Mode is `admin` put `All` into All%0a  else put empty into All%0a  put empty into TrackingMessage%0a  if TrackingMessage put `home` into Item else put `enter` into Item%0a  set property `event` of TrackingMessage to Item%0a%0a  if Selector set property `filter` of TrackingMessage to Selector%0a  if Selector is `section`%0a  begin%0a    set property `section` of TrackingMessage to Section%0a    rest get ArticleCount from `_/yw_sections/count/` cat Section%0a      or go to DataReadFail%0a  end%0a  else if Selector is `author`%0a  begin%0a    set property `author` of TrackingMessage to Author%0a    rest get ArticleCount from `_/yw_authors/count/` cat Author%0a      or go to DataReadFail%0a  end%0a  else if Selector is `tag`%0a  begin%0a    set property `tag` of TrackingMessage to Tag%0a    rest get ArticleCount from `_/yw_tags/count/` cat Tag%0a      or go to DataReadFail%0a  end%0a  else%0a  begin%0a    rest get ArticleCount from `_/yw_articles/count` cat All%0a      or go to DataReadFail%0a  end%0a  gosub to Tracking%0a  put the value of ArticleCount into ArticleCount%0a%0a  if ArticleCount is greater than 10%0a  begin%0a    set style `display` of NavigatorDiv to `block`%0a  end else begin%0a    set style `display` of NavigatorDiv to `none`%0a  end%0a%0a  if Selector is `section`%0a    rest get Articles from `_/yw_articles/get/section/` cat Section%0a      or go to DataReadFail%0a  else if Selector is `author`%0a    rest get Articles from `_/yw_articles/get/author/` cat Author%0a      or go to DataReadFail%0a  else if Selector is `tag`%0a    rest get Articles from `_/yw_articles/get/tag/` cat Tag%0a      or go to DataReadFail%0a  else%0a  begin%0a    multiply CurrentPage by 10 giving N%0a    rest get Articles from `_/yw_articles/get` cat All cat `/` cat N%0a      or go to DataReadFail%0a  end%0a%0a  put the json count of Articles into N%0a  put 10 into DisplayCount%0a  if N is less than DisplayCount put N into DisplayCount%0a%0a  set the elements of Block to DisplayCount%0a  set the elements of SectionText to DisplayCount%0a  set the elements of TitleLink to DisplayCount%0a  set the elements of SynopsisText to DisplayCount%0a  set the elements of SynopsisGroup to DisplayCount%0a  set the elements of EditButton to DisplayCount%0a  set the elements of SectionLink to DisplayCount%0a%0a  set the content of Blocks to ``%0a  if Selector is `author`%0a  begin%0a    create SelectorDiv in Blocks%0a    set the style of SelectorDiv to `font-weight:bold;color:green;margin-bottom:0.5em`%0a    replace `%20` with ` ` in Author%0a    set the content of SelectorDiv to `Articles by ` cat Author%0a  end%0a  else if Selector is `tag`%0a  begin%0a    create SelectorDiv in Blocks%0a    set the style of SelectorDiv to `font-weight:bold;color:green;margin-bottom:0.5em`%0a    set the content of SelectorDiv to `Articles with tag ~sq~` cat Tag cat `~sq~`%0a  end%0a%0a  put 0 into Index%0a  while Index is less than DisplayCount%0a  begin%0a    index Block to Index%0a    index SectionText to Index%0a    index TitleLink to Index%0a    index SynopsisGroup to Index%0a    index SynopsisText to Index%0a    index EditButton to Index%0a    create Block in Blocks%0a    set the style of Block to `position:relative`%0a    create EditButton in Block%0a    set the style of EditButton to%0a      `position:absolute;top:0.25em;right:0.25em;width:25px;display:none`%0a    set attribute `src` of EditButton to %0a      `https://yorkshirewoman.uk/resources/system/edit.png`%0a    set attribute `title` of EditButton to `Edit this article`%0a    create SectionText in Block%0a    set the style of SectionText to `font-weight:bold;color:#f08`%0a    create TitleLink in Block%0a    set the style of TitleLink to `font-size:1.2em;font-weight:bold;margin-bottom:1em`%0a    create SynopsisGroup in Block%0a    create SynopsisText in SynopsisGroup%0a%0a    on click EditButton%0a    begin%0a      put the index of EditButton into Index%0a      put element Index of Articles into Article%0a      go to Editor%0a    end%0a    add 1 to Index%0a  end%0a%0a  gosub to ShowSynopses%0a  if Mode is `admin` return%0a  if CurrentPage is not 0 gosub to EnableHomeButton%0a  else if Selector is empty gosub to DisableHomeButton%0a  else gosub to EnableHomeButton%0a%0aDoFooter:%0a  if not mobile%0a  begin%0a    set the style of CopyrightDiv to%0a      `clear:both;border-top:1px solid gray;text-align:center;font-size:80%`%0a    put now into Content%0a    put Content format CopyrightFormat into Content%0a    set the content of CopyrightDiv to `&copy;` cat Content cat ` YorkshireWoman`%0a  end%0a  return%0a%0aDataReadFail:%0a  alert `Unable to read data - you may have to restart.`%0a  stop%0a%0aShowSynopses:%0a  put 0 into Index%0a  while Index is less than DisplayCount%0a  begin%0a    index Block to Index%0a    index EditButton to Index%0a    index SectionText to Index%0a    index TitleLink to Index%0a    index SynopsisGroup to Index%0a    index SynopsisText to Index%0a    index SectionLink to Index%0a    gosub to ShowSynopsis%0a    add 1 to Index%0a  end%0a  return%0a%0aShowSynopsis:%0a  if Mode is `admin` set style `display` of EditButton to `inline-block`%0a  put element Index of Articles into Article%0a  set style `display` of Block to `block`%0a  if property `public` of Article set style `background` of Block to ``%0a  else%0a  begin%0a    if Mode is `admin` set style `background` of Block to `#fee`%0a    else set style `display` of Block to `none`%0a  end%0a  put decode property `section` of Article into Section%0a  set the content of SectionText to Section%0a  set the content of TitleLink to decode property `title` of Article%0a  set attribute `href` of TitleLink to%0a    `https://yorkshirewoman.uk/?` cat property `slug` of Article%0a  on click TitleLink%0a  begin%0a    put the index of TitleLink into Index%0a    put element Index of Articles into Article%0a    gosub to TrackArticle%0a    gosub to Viewer%0a  end%0a  set the content of SynopsisText to decode property `synopsis` of Article%0a  create DateGroup in SynopsisGroup%0a  set the style of DateGroup to%0a    `margin-bottom:0.5em;border-bottom:1px solid black;font-size:85%`%0a  put property `published` of Article into Published%0a  set the content of DateGroup to Published format DateFormat%0a  if Section%0a  begin%0a    create Span in DateGroup%0a    set the style of Span to `padding-left:3em`%0a    set the content of Span to `Section: `%0a    create SectionLink in DateGroup%0a    set the content of SectionLink to Section%0a    on click SectionLink%0a    begin%0a      put `section` into Selector%0a      put the content of SectionLink into Section%0a      put 0 into CurrentPage%0a      scroll to 0%0a      gosub to RedrawBlocks%0a      gosub to EnableHomeButton%0a    end%0a  end%0a  return%0a%0aEnableHomeButton:%0a  put `` into ButtonMessage%0a  set property `button` of ButtonMessage to `home`%0a  set property `action` of ButtonMessage to `enable`%0a  send ButtonMessage to Menu%0a  return%0a%0aDisableHomeButton:%0a  put `` into ButtonMessage%0a  set property `button` of ButtonMessage to `home`%0a  set property `action` of ButtonMessage to `disable`%0a  send ButtonMessage to Menu%0a  return%0a%0aEnableAboutButton:%0a  put `` into ButtonMessage%0a  set property `button` of ButtonMessage to `about`%0a  set property `action` of ButtonMessage to `enable`%0a  send ButtonMessage to Menu%0a  return%0a%0aDisableAboutButton:%0a  put `` into ButtonMessage%0a  set property `button` of ButtonMessage to `about`%0a  set property `action` of ButtonMessage to `disable`%0a  send ButtonMessage to Menu%0a  return%0a%0aEnableMenuButton:%0a  put `` into ButtonMessage%0a  set property `button` of ButtonMessage to `menu`%0a  set property `action` of ButtonMessage to `enable`%0a  send ButtonMessage to Menu%0a  return%0a%0aDisableMenuButton:%0a  put `` into ButtonMessage%0a  set property `button` of ButtonMessage to `menu`%0a  set property `action` of ButtonMessage to `disable`%0a  send ButtonMessage to Menu%0a  return%0a%0aViewSlug:%0a  rest get Article from `_/yw_articles/slug/` cat Slug%0a  or begin%0a    alert `Unable to read article - please try again.`%0a    stop%0a  end%0a  put `` into TrackingMessage%0a  set property `event` of TrackingMessage to `slug`%0a  go to TA2%0a%0aTrackArticle:%0a  put `` into TrackingMessage%0a  set property `event` of TrackingMessage to `article`%0aTA2:%0a  set property `article` of TrackingMessage to property `id` of Article%0a  gosub to Tracking%0a%0aViewer:%0a  put the scroll position into ScrollPosition%0a  scroll to 0%0a  put `` into ViewerMessage%0a  if not ArticleViewerRunning%0a  begin%0a    rest get Script from `ec_scripts/name/viewer`%0a    or begin%0a      alert `Unable to get the viewer script - please try again.`%0a      stop%0a    end%0a    run Script with CenterColumn and Article and Mode and ViewerMessage%0a      as ArticleViewer%0a    set ArticleViewerRunning%0a  end%0a  put `` into HistoryState%0a  set property `script` of HistoryState to `Yorkshirewoman`%0a  set property `url` of HistoryState to%0a    property `protocol` of Args cat property `domain` of Args%0a  history set state HistoryState%0a  on restore%0a  begin%0a    if CurrentPage is 0 gosub to DisableHomeButton%0a    gosub to EnableAboutButton%0a    if Location is not `home`%0a    begin %0a      close ArticleViewer%0a      put the history state into HistoryState%0a      if HistoryState is not empty%0a      begin%0a        history set url property `url` of HistoryState%0a      end%0a      put `home` into Location%0a      if ViewerMessage is `show` go to ViewSlug%0a      if ViewerMessage is `edit`%0a      begin%0a         if Mode is `admin` go to Editor%0a         stop%0a      end%0a      if property `action` of ViewerMessage is `section`%0a      begin%0a        put property `name` of ViewerMessage into Section%0a        put `section` into Selector%0a        gosub to EnableHomeButton%0a        gosub to RedrawBlocks%0a      end%0a      else if property `action` of ViewerMessage is `author`%0a      begin%0a        put property `name` of ViewerMessage into Author%0a        put `author` into Selector%0a        gosub to EnableHomeButton%0a        gosub to RedrawBlocks%0a      end%0a      else if property `action` of ViewerMessage is `tag`%0a      begin%0a        put property `tag` of ViewerMessage into Tag%0a        put `tag` into Selector%0a        gosub to EnableHomeButton%0a        gosub to RedrawBlocks%0a      end%0a      else%0a      begin%0a        put `` into TrackingMessage%0a        set property `event` of TrackingMessage to `home`%0a        set property `filter` of TrackingMessage to ``%0a        gosub to Tracking%0a      end%0a    end%0a    set style `display` of Buttons to `block`%0a    set style `display` of Blocks to `block`%0a    if ArticleCount is greater than 10 set style `display` of NavigatorDiv to `block`%0a    if Mode is `admin`%0a    begin%0a      set style `display` of NewButton to `block`%0a      set style `display` of ToolsButton to `block`%0a    end%0a    wait 10 ticks%0a    scroll to ScrollPosition%0a  end%0a%0a  put `show` into Location%0a  if Selector is not `section` put `` into Section%0a  send to ArticleViewer%0a  set style `display` of Buttons to `none`%0a  set style `display` of Blocks to `none`%0a  set style `display` of NavigatorDiv to `none`%0a  gosub to EnableHomeButton%0a  return%0a%0aEditSlug:%0a  rest get Article from `_/yw_articles/slug/` cat Slug%0a  or begin%0a    alert `Unable to get the article - please try again.`%0a    stop%0a  end%0a%0aEditor:%0a  put `` into Message%0a  if not ArticleEditorRunning%0a  begin%0a    load plugin `ui`%0a    load plugin `ckeditor`%0a    rest get Script from `ec_scripts/name/editor`%0a    or begin%0a      alert `Unable to get the editor script - please try again.`%0a      stop%0a    end%0a    run Script with Body and CenterColumn and Article and Message as ArticleEditor%0a    set ArticleEditorRunning%0a  end%0a  history set%0a  on restore%0a  begin%0a    if CurrentPage is 0 gosub to DisableHomeButton%0a    gosub to EnableAboutButton%0a    put Article into Record%0a    close ArticleEditor%0a    gosub to RedrawBlocks%0a    put `home` into Location%0a    if Message is `show`%0a    begin%0a      put Record into Article%0a      gosub to Viewer%0a      stop%0a    end%0a    set style `display` of NewButton to `inline-block`%0a    set style `display` of ToolsButton to `inline-block`%0a    set style `display` of Blocks to `block`%0a    if ArticleCount is greater than 10 set style `display` of NavigatorDiv to `block`%0a  end%0a%0a  put `edit` into Location%0a  send to ArticleEditor%0a  set style `display` of NewButton to `none`%0a  set style `display` of ToolsButton to `none`%0a  set style `display` of Blocks to `none`%0a  set style `display` of NavigatorDiv to `none`%0a  gosub to EnableHomeButton%0a  gosub to DisableAboutButton%0a  stop%0a%0aTracking:%0a  if Mode is not `admin`%0a  begin%0a    rest post TrackingMessage to `_/ec_visits/log/` cat Visitor or%0a    begin%0a      print `Tracking request failed. Message was ` cat TrackingMessage%0a    end%0a  end%0a  return', 1558006141),
(18, 'analytics', '  script Analytics%0a%0a  div Body%0a  div Main%0a  div Analysis%0a  div AnalysisTitle%0a  div DataPanel%0a  div VisitorsPanel%0a  div MapPanel%0a  div InfoPanel%0a  div Title%0a  div LowerInfoPanel%0a  span Span%0a  date StartDateEditor%0a  date EndDateEditor%0a  a SearchLink%0a  a ShowAllLink%0a  module VisitorsModule%0a  module VisitorModule%0a  module MapModule%0a  variable Password%0a  variable Valid%0a  variable Result%0a  variable DateFormat%0a  variable StartDate%0a  variable EndDate%0a  variable Value%0a  variable Script%0a  variable Message%0a  variable VID%0a  variable Info%0a  variable Location%0a  %0a  get Password from storage as `password`%0a  rest get Valid from `_verify/` cat Password%0a    or alert `Unable to verify password - please try again.`%0a  if Valid is not `yes` location `https://yorkshirewoman.uk`%0a%0a  load plugin `gmap`%0a%0a  get StartDate from storage as `startdate`%0a  get EndDate from storage as `enddate`%0a  if not StartDate put today into StartDate%0a  if not EndDate put today into EndDate%0a%0a  put empty into DateFormat%0a  set property `mode` of DateFormat to `date`%0a  set property `locale` of DateFormat to `en-EN`%0a  put empty into Value%0a  set property `weekday` of Value to `long`%0a  set property `year` of Value to `numeric`%0a  set property `month` of Value to `long`%0a  set property `day` of Value to `numeric`%0a  set property `options` of DateFormat to Value%0a%0a  create Body%0a  set the style of Body to `width:calc(100vw - 20px);height:calc(100vh - 20px);overflow:hidden`%0a%0a  create Main in Body%0a  set the style of Main to `width:100%;height:100%;margin:2em 1em 0 1em`%0a%0a  create Analysis in Main%0a  set the style of Analysis to%0a    `width:calc(100% - 30px);height:calc(50% - 2em - 30px);border:1px solid black;` cat%0a    `margin:1em 0 0 0;padding:0.5em;background:#ffe`%0a  create AnalysisTitle in Analysis%0a  set the style of AnalysisTitle to%0a    `position:relative;top:-1em;margin-left:1em;display:inline;` cat%0a    `background-color:white;padding:0.5em;border:1px solid black;background:#eff` %0a  create Span in AnalysisTitle%0a  set the content of Span to `Analysis: From `%0a  create Span in AnalysisTitle%0a  create StartDateEditor in Span%0a  set the date of StartDateEditor to StartDate%0a  create Span in AnalysisTitle%0a  set the content of Span to ` to `%0a  create Span in AnalysisTitle%0a  create EndDateEditor in Span%0a  set the date of EndDateEditor to EndDate%0a  create Span in AnalysisTitle%0a  set the content of Span to ` (inclusive)&nbsp;&nbsp;&nbsp;`%0a  create SearchLink in AnalysisTitle%0a  set the content of SearchLink to `Search`%0a  create InfoPanel in Analysis%0a  on click SearchLink%0a  begin%0a    clear InfoPanel%0a    clear VisitorsPanel%0a    clear MapPanel%0a    go to GetVisitors%0a  end%0a%0a  create DataPanel in Main%0a  set the style of DataPanel to%0a    `width:calc(100% - 30px);height:calc(50% - 2em - 30px);border:1px solid black;` cat%0a    `margin:3em 0 0 0;padding:0.5em;background:#ffe;display:flex`%0a  create VisitorsPanel in DataPanel%0a  set the style of VisitorsPanel to `flex:50`%0a  create MapPanel in DataPanel%0a  set the style of MapPanel to `flex:50`%0a%0a  rest get Script from `ec_scripts/name/analytics-visitors`%0a    or alert `Unable to load the visitors script - please restart.`%0a  run Script with VisitorsPanel and Result as VisitorsModule%0a  rest get Script from `ec_scripts/name/analytics-visitor`%0a    or alert `Unable to load the visitor script - please restart.`%0a  run Script with LowerInfoPanel and Info as VisitorModule%0a  rest get Script from `ec_scripts/name/analytics-map`%0a    or alert `Unable to load the map script - please restart.`%0a  run Script with MapPanel and Message as MapModule%0a%0a  on message%0a  begin%0a    put the message into Message%0a    if property `action` of Message is `visitor`%0a    begin%0a      put property `visitor` of Message into VID%0a      go to ShowVisitor%0a    end%0a    else if property `action` of Message is `map`%0a    begin%0a    	put property `vid` of Message into VID%0a    	put property `location` of Message into Location%0a        put empty into Message%0a        set property `vid` of Message to VID%0a        set property `location` of Message to Location%0a        set property `zoom` of Message to 12%0a        send to MapModule%0a    end%0a  end%0a%0aGetVisitors:%0a  put StartDateEditor into StartDate%0a  put EndDateEditor into EndDate%0a  put StartDate into storage as `startdate`%0a  put EndDate into storage as `enddate`%0a  add 60*60*24 to EndDate%0a  set the style of InfoPanel to `height:calc(100% - 2em);overflow-y:auto`%0a  create Title in InfoPanel%0a  set the style of Title to `margin-bottom:1em`%0a  create Span in Title%0a  set the style of Span to `font-weight:bold`%0a  set the content of Span to `Searching...`%0a  create LowerInfoPanel in InfoPanel%0a  set the style of LowerInfoPanel to `height:calc(100% - 2.5em);overflow-y:auto`%0a  rest get Result from `_/ec_visitors/dates/` cat StartDate cat `/` cat EndDate%0a    or alert `REST call failed`%0a  set the content of Span to `Visitors: ` cat the json count of Result cat `&nbsp;&nbsp;&nbsp;`%0a  create ShowAllLink in Title%0a  set the content of ShowAllLink to `Show All`%0a  on click ShowAllLink go to ShowAll%0a%0a  send to VisitorsModule%0a  stop%0a%0aShowAll:%0a  alert `Show All`%0a  stop%0a%0aShowVisitor:%0a  clear LowerInfoPanel%0a  rest get Info from `_/ec_visits/single/` cat VID cat `/` cat StartDate cat `/` cat EndDate%0a  send to VisitorModule%0a  stop%0a', 1559768266),
(19, 'analytics-visitors', '    script AnalyticsVisitors%0a%0a    import div Container%0a        and variable List%0a%0a    div Legend%0a    div Visitor%0a    div Results%0a    div Progress%0a    div Div%0a    span Span%0a    a VisitorLink%0a    a MapLink%0a    variable Record%0a    variable NVisitors%0a    variable N%0a    variable VID%0a    variable IP%0a    variable HostName%0a    variable City%0a    variable Region%0a    variable County%0a    variable Location%0a    variable Postcode%0a    variable Organisation%0a    variable VisitorData%0a    variable Message%0a%0a    on message go to Run%0a    set ready%0a    stop%0a%0a  Run:%0a    clear Container%0a    create Legend in Container%0a    set the style of Legend to%0a        `position:relative;top:-1em;margin-left:1em;display:inline;` cat%0a        `background-color:white;padding:0.5em;border:1px solid black;background:#eff` %0a    create Span in Legend%0a    set the content of Span to `Visitors`%0a    create Progress in Container%0a    set the content of Progress to `Loading visitor data`%0a    create Results in Container%0a    set the style of Results to `display:none;height:calc(100% - 2em);overflow-y:auto`%0a%0a    put the json count of List into NVisitors%0a    set the elements of Visitor to NVisitors%0a    set the elements of VisitorLink to NVisitors%0a    set the elements of MapLink to NVisitors%0a    set the elements of VID to NVisitors%0a    set the elements of Location to NVisitors%0a    clear Results%0a    put 0 into N%0a    while N is less than NVisitors%0a    begin%0a        create Span in Progress%0a        set the content of Span to `.`%0a%0a        index Visitor to N%0a        index VisitorLink to N%0a        index MapLink to N%0a        index VID to N%0a        index Location to N%0a%0a        create Visitor in Results%0a        set the style of Visitor to `margin-bottom:1em`%0a        put element N of List into Record%0a        put property `vid` of Record into VID%0a        put property `ip` of Record into IP%0a        put property `hostname` of Record into HostName%0a        put property `city` of Record into City%0a        put property `region` of Record into Region%0a        put property `county` of Record into County%0a        put property `loc` of Record into Location%0a        put property `postal` of Record into Postcode%0a        put property `org` of Record into Organisation%0a%0a        create Div in Visitor%0a        set the style of Div to%0a			`display:inline-block;font-weight:bold;margin:0.5em;border:1px solid black`%0a        create VisitorLink in Div%0a        set the style of VisitorLink to `display:block;padding:0.5em;background:#eee`%0a        set the content of VisitorLink to `Visitor ` cat VID%0a        on click VisitorLink%0a        begin%0a			index VID to the index of VisitorLink%0a			put element N of List into Record%0a			put empty into Message%0a			set property `action` of Message to `visitor`%0a			set property `visitor` of Message to VID%0a			send Message to parent%0a		end%0a%0a		rest get VisitorData from `_/ec_visitors/visitor/` cat VID%0a		create Div in Visitor%0a		set the content of Div to `Agent: ` cat property `agent` of VisitorData%0a%0a        if IP%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `IP: ` cat IP%0a        end%0a        if HostName%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `HostName: ` cat HostName%0a        end%0a        if City%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `City: ` cat City%0a        end%0a        if Region%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `Region: ` cat Region%0a        end%0a        if County%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `County: ` cat County%0a        end%0a        if Location%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `Location: ` cat Location cat `&nbsp&nbsp&nbsp&nbsp;`%0a            create MapLink in Div%0a            set the style of MapLink to `border:1px solid black;padding:0.2em;background:#eee`%0a            set the content of MapLink to `Show`%0a            on click MapLink%0a            begin%0a            	index VID to the index of MapLink%0a            	index Location to the index of MapLink%0a            	put empty into Message%0a                set property `action` of Message to `map`%0a                set property `vid` of Message to VID%0a                set property `location` of Message to Location%0a                send Message to parent%0a            end%0a        end%0a        if Postcode%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `Postcode: ` cat Postcode%0a        end%0a        if Organisation%0a        begin%0a            create Div in Visitor%0a            set the content of Div to `Organisation: ` cat Organisation%0a        end%0a        add 1 to N%0a    end%0a    set style `display` of Results to `block`%0a    set style `display` of Progress to `none`%0a    stop%0a', 1557676910),
(20, 'analytics-visitor', '  script AnalyticsVisitor%0a%0a  import div Container%0a    and variable EventList%0a%0a  div Events%0a  div Div%0a  span Span%0a  variable Record%0a  variable NEvents%0a  variable N%0a  variable DateFormat%0a  variable TimeFormat%0a  variable Content%0a  variable VID%0a  variable TS%0a  variable Event%0a  variable ArticleID%0a  variable Article%0a%0a  put empty into DateFormat%0a  set property `mode` of DateFormat to `date`%0a  set property `locale` of DateFormat to `en-EN`%0a  put empty into Content%0a  set property `hour` of Content to `numeric`%0a  set property `minute` of Content to `numeric`%0a  set property `second` of Content to `numeric`%0a  set property `year` of Content to `numeric`%0a  set property `month` of Content to `long`%0a  set property `day` of Content to `numeric`%0a  set property `options` of DateFormat to Content%0a%0a  put empty into TimeFormat%0a  set property `mode` of TimeFormat to `time`%0a  set property `locale` of TimeFormat to `en-EN`%0a  put empty into Content%0a  set property `hour` of Content to `numeric`%0a  set property `minute` of Content to `numeric`%0a  set property `second` of Content to `numeric`%0a  set property `options` of TimeFormat to Content%0a%0a  on message go to Run%0a  set ready%0a  stop%0a%0aRun:%0a  clear Container%0a  put the json count of EventList into NEvents%0a  create Events in Container%0a  put 0 into N%0a  put element 0 of EventList into Record%0a  put property `vid` of Record into VID%0a  create Div in Events%0a  set the style of Div to `font-weight:bold`%0a  set the content of Div to `Visitor ` cat VID%0a  while N is less than NEvents%0a  begin%0a    put element N of EventList into Record%0a%0a    create Div in Events%0a    put property `ts` of Record into TS%0a    create Span in Div%0a    set the content of Span to TS format DateFormat %0a    create Span in Div%0a    set the content of Span to `: `%0a    put property `event` of Record into Event%0a    create Span in Div%0a    set the content of Span to Event%0a    if Event is `article` gosub to ShowArticle%0a    if Event is `slug` gosub to ShowArticle%0a%0a    add 1 to N%0a  end%0a  stop%0a%0aShowArticle:%0a  put property `article` of Record into ArticleID%0a  create Span in Div%0a  set the content of Span to ` ` cat ArticleID%0a  rest get Article from `_/yw_articles/id/` cat ArticleID%0a  create Span in Div%0a  set the content of Span to `: `%0a  create Span in Div%0a  set the content of Span to property `title` of Article%0a  return%0a', 1557680548),
(21, '', '  script AnalyticsVisitor%0a%0a  import div Container%0a    and variable EventList%0a%0a  div Events%0a  div Div%0a  span Span%0a  variable Record%0a  variable NEvents%0a  variable N%0a  variable DateFormat%0a  variable TimeFormat%0a  variable Content%0a  variable VID%0a  variable Timestamp%0a  variable TS%0a  variable Event%0a  variable ArticleID%0a%0a  put empty into DateFormat%0a  set property `mode` of DateFormat to `date`%0a  set property `locale` of DateFormat to `en-EN`%0a  put empty into Content%0a  set property `hour` of Content to `numeric`%0a  set property `minute` of Content to `numeric`%0a  set property `second` of Content to `numeric`%0a  set property `weekday` of Content to `long`%0a  set property `year` of Content to `numeric`%0a  set property `month` of Content to `long`%0a  set property `day` of Content to `numeric`%0a  set property `options` of DateFormat to Content%0a%0a  put empty into TimeFormat%0a  set property `mode` of TimeFormat to `time`%0a  set property `locale` of TimeFormat to `en-EN`%0a  put empty into Content%0a  set property `hour` of Content to `numeric`%0a  set property `minute` of Content to `numeric`%0a  set property `second` of Content to `numeric`%0a  set property `options` of TimeFormat to Content%0a%0a  on message go to Run%0a  set ready%0a  stop%0a%0aRun:%0a  clear Container%0a  put the json count of EventList into NEvents%0a  create Events in Container%0a  put 0 into N%0a  put element 0 of EventList into Record%0a  put property `vid` of Record into VID%0a  put property `ts` of Record into Timestamp%0a  create Div in Events%0a  set the style of Div to `font-weight:bold`%0a  set the content of Div to `Visitor ` cat VID cat `: ` cat Timestamp format DateFormat%0a  while N is less than NEvents%0a  begin%0a    put element N of EventList into Record%0a%0a    create Div in Events%0a    put property `ts` of Record into TS%0a    create Span in Div%0a    set the content of Span to `At ` cat TS format TimeFormat %0a    create Span in Div%0a    set the content of Span to `: `%0a    put property `event` of Record into Event%0a    create Span in Div%0a    set the content of Span to Event%0a    if Event is `article`%0a    begin%0a      put property `article` of Record into ArticleID%0a      create Span in Div%0a      set the content of Span to ArticleID%0a    end%0a%0a    add 1 to N%0a  end%0a  stop%0a', 1557176603),
(22, 'scripted', '  script ScriptEditor%0a%0a  div Body%0a  div Container%0a  div Buttons%0a  div ScriptName%0a  div ContentDiv%0a  input NameEditor%0a  textarea ContentEditor%0a  span Status%0a  span Span%0a  button Open%0a  button Save%0a  button Delete%0a  variable Name%0a  variable CurrentName%0a  variable Content%0a  variable Current%0a  variable Password%0a  variable Valid%0a%0a! The browser%0a  div Overlay%0a  div Scroller%0a  div Media%0a  div FileListing%0a  div FileRow%0a  button CloseButton%0a  a FileName%0a  variable Alpha%0a  variable FileList%0a  variable FileCount%0a  variable File%0a  variable N%0a  variable FileIsOpen%0a%0a  set the title to `Script Editor`%0a%0a  get Password from storage as `password`%0a  if Password is empty%0a    put prompt `Please type the admin password` with `` into Password%0a  rest get Valid from `_verify/` cat Password%0a  or alert `Unable to verify password - please try again.`%0a  if Valid is `yes` put Password into storage as `password`%0a  %0a  create Body%0a  create Container in Body%0a  set the style of Container to `width:70%;margin:0 auto;background #ffe`%0a%0a  create Buttons in Container%0a  set the style of Buttons to `text-align:center`%0a%0a  create Open in Buttons%0a  set the style of Open to `margin-right:0.5em`%0a  set the text of Open to `Open`%0a  create Save in Buttons%0a  set the text of Save to `Save`%0a  set the style of Save to `margin-right:4em`%0a  create Delete in Buttons%0a  set the text of Delete to `Delete`%0a  create Status in Buttons%0a  set the style of Status to `position:absolute;float:right;padding-left:2em;padding-top:1em;color:green`%0a%0a  create ScriptName in Container%0a  set the style of ScriptName to `display:flex;margin:0.5em 0`%0a  create Span in ScriptName%0a  set the style of Span to `flex:15`%0a  set the content of Span to `Script name:&nbsp;`%0a  create NameEditor in ScriptName%0a  set the style of NameEditor to `flex:85;display:inline-block`%0a  set the size of NameEditor to 40%0a%0a  create ContentDiv in Container%0a  set the style of ContentDiv to `width:100%;height:85%;border:1px solid lightgray`%0a%0a  create ContentEditor in ContentDiv%0a  set the style of ContentEditor to `width:100%;height:100%`%0a%0a  codemirror init basic profile `/wp-content/plugins/easycoder/plugins/codemirror-ecs.js`%0a%0a  require css `https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.46.0/addon/dialog/dialog.css`%0a  require js `https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.46.0/addon/dialog/dialog.js`%0a  require js `https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.46.0/addon/search/search.js`%0a  require js `https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.46.0/addon/search/searchcursor.js`%0a  require js `https://cdnjs.cloudflare.com/ajax/libs/codemirror/5.46.0/addon/search/jump-to-line.js`%0a%0a  create Overlay%0a  set the style of Overlay to%0a    `position:absolute;top:0;left:0;width:100vw;height:100vh;background:rgba(0,0,0,0.0);display:none`%0a%0a  create Media in Overlay%0a  set style of Media to `display:none;width:100%;height:100%;text-align:center`%0a%0a  create FileListing in Media%0a  set the style of FileListing to%0a    `display:none;width:50%;height:75%;margin:auto;background-color:white;`%0a    cat `padding:2em 2em 3em 2em;text-align:center;position: absolute;top: 50%;left: 50%;`%0a    cat `transform: translateX(-50%) translateY(-50%)`%0a%0a  create Scroller in FileListing%0a  set the style of Scroller to `height:100%;overflow:scroll;text-align:left`%0a%0a  create CloseButton in FileListing%0a  set the text of CloseButton to `Close`%0a%0a  put empty into Current%0a  clear FileIsOpen%0a%0a  on click Save%0a  begin%0a    put the content of NameEditor into Name%0a    if Name is empty%0a    begin%0a      set the content of Status to `No script name has been given`%0a      go to ResetStatus%0a    end%0a    replace ` ` with `_` in Name%0a    codemirror close ContentEditor%0a    put the content of ContentEditor into Content%0a    if Content is not Current%0a    begin%0a      rest post Content to `ec_scripts/set/name/` cat Name%0a      put Content into Current%0a      set the content of Status to `Script ~sq~` cat Name cat `~sq~ saved`%0a      fork to ResetStatus%0a    end%0a    else%0a    begin%0a      set the content of Status to `Nothing has changed`%0a      fork to ResetStatus%0a    end%0a    codemirror attach to ContentEditor%0a  end%0a%0a  on click Open go to DoOpen%0a%0a  on click Delete%0a  begin%0a    put the content of NameEditor into Name%0a    if Name is empty%0a    begin%0a      alert `Nothing to delete.`%0a      stop%0a    end%0a    if confirm `Are you sure you want to delete ~sq~` cat Name cat `~sq~?`%0a    begin%0a      codemirror close ContentEditor%0a      rest post to `ec_scripts/delete/` cat Name%0a      set the content of Status to `Script ~sq~` cat Name cat `~sq~ deleted`%0a      set the content of NameEditor to empty%0a      put empty into Content%0a      set the content of ContentEditor to Content%0a      put Content into Current%0a      go to ResetStatus%0a    end%0a  end%0a  stop%0a%0aDoOpen:%0a  if FileIsOpen codemirror close ContentEditor%0a  put the content of ContentEditor into Content%0a  if Content is not Current%0a  begin%0a    if confirm `Content has changed. Do you want to save it?`%0a    begin%0a      rest post Content to `ec_scripts/set/name/` cat CurrentName%0a    end%0a  end%0a%0a! Animate the background%0a  set style `display` of Overlay to `block`%0a  put 0 into Alpha%0a  while Alpha is less than 8%0a  begin%0a    set style `background-color` of Overlay to `rgba(0,0,0,0.` cat Alpha cat `)`%0a    wait 4 ticks%0a    add 1 to Alpha%0a  end%0a  wait 10 ticks%0a%0a! Make the browser panel visible%0a  set style `display` of Media to `block`%0a  set style `display` of FileListing to `inline-block`%0a%0a! Fill the browser with content from the server%0a  rest get Content from `ec_scripts/names/0/1000`%0a  put empty into FileList%0a  put the json count of Content into FileCount%0a  set the elements of File to FileCount%0a  set the elements of FileName to FileCount%0a! Add a row for each file%0a  put 0 into N%0a  while N is less than FileCount%0a  begin%0a    index File to N%0a    index FileName to N%0a    put `<div id=~dq~ec-file-row-INDEX~dq~ style=~dq~clear:both;padding:0.25em 0;~dq~>`%0a      cat `<a id=~dq~ec-file-name-INDEX~dq~ href=~dq~#~dq~></a></div>` into File%0a    replace `INDEX` with N in File%0a    if N is even replace `ODDEVEN` with `ec-even` in File%0a    else replace `ODDEVEN` with `ec-odd` in File%0a    put FileList cat File into FileList%0a    add 1 to N%0a  end%0a%0a  set the content of Scroller to FileList%0a! Add the document names%0a  put 0 into N%0a  while N is less than FileCount%0a  begin%0a    index File to N%0a    index FileName to N%0a    put element N of Content into File%0a    attach FileRow to `ec-file-row-` cat N%0a    attach FileName to `ec-file-name-` cat N%0a    set the content of FileName to File%0a    if N is even set style `background` of FileRow to `lightgray`%0a    on click FileName go to SelectFile%0a    add 1 to N%0a  end%0a  on click CloseButton%0a  begin%0a    clear FileIsOpen%0a    go to CloseBrowser%0a  end%0a  set FileIsOpen%0a  stop%0a%0aSelectFile:%0a  index File to the index of FileName%0a  set the content of NameEditor to File%0a  rest get Content from `ec_scripts/name/` cat File%0a  set the content of Status to `Script ~sq~` cat File cat `~sq~ loaded`%0a  fork to ResetStatus%0a  codemirror attach to ContentEditor%0a  codemirror set content of ContentEditor to Content%0a  put Content into Current%0a  set the title to `Script Editor - ` cat File%0a%0aCloseBrowser:%0a  set style `background-color` of Overlay to `rgba(0,0,0,0.0)`%0a  set style `display` of Overlay to `none`%0a  set style `display` of Media to `none`%0a  stop%0a%0aResetStatus:%0a  wait 2%0a  set the content of Status to ``%0a  stop%0a', 1559768385);
INSERT INTO `ec_scripts` (`id`, `name`, `value`, `ts`) VALUES
(23, 'analytics-map', '    script AnalyticsMap%0a%0a    import div Container%0a        and variable Message%0a    %0a    gmap Map%0a    marker Marker%0a    variable Location%0a    variable Latitude%0a    variable Longitude%0a    variable Zoom%0a    variable Key%0a    variable N%0a    variable Position%0a%0a    on message go to Run%0a    set ready%0a    stop%0a%0aRun:%0a    clear Container%0a    put property `location` of Message into Location%0a    put the position of `,` in Location into N%0a    put left N of Location into Latitude%0a    add 1 to N%0a    take N from the length of Location giving N%0a    put right N of Location into Longitude%0a    put property `zoom` of Message into Zoom%0a%0a	create Map in Container%0a	rest get Key from `ec_data/name/key`%0a	set the key of Map to Key%0a	set the latitude of Map to Latitude%0a	set the longitude of Map to Longitude%0a	set the zoom of Map to Zoom%0a	show Map%0a    %0a    put `{}` into Position%0a    set property `latitude` of Position to Latitude%0a    set property `longitude` of Position to Longitude%0a    create Marker in Map%0a    set the position of Marker to Position%0a    set the title of Marker to `Visitor ` cat property `vid` of Message%0a%0a	stop', 1557676832);

-- --------------------------------------------------------

--
-- Table structure for table `ec_user`
--

CREATE TABLE `ec_user` (
  `email` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `password` text CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `name` varchar(40) CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci NOT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Dumping data for table `ec_user`
--

INSERT INTO `ec_user` (`email`, `password`, `name`, `admin`) VALUES
('admin@normanton.life', '$2y$10$hxzBqEZwJCyir8l22B5ci.2NKrnmZegotOGkFsH1oqamAMrvYuusq', 'nlife', 1),
('gt@pobox.com', '$2y$10$pCRPffJy9HnCrzUDpJlMFu7Mw6Z8974AyXMdrJUN3MvAp1ocKptVy', 'tramontana', 0);

-- --------------------------------------------------------

--
-- Table structure for table `ec_visitors`
--

CREATE TABLE `ec_visitors` (
  `id` int NOT NULL,
  `ip` char(15) NOT NULL DEFAULT '',
  `ts` int NOT NULL DEFAULT '0',
  `agent` varchar(400) DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `ec_visits`
--

CREATE TABLE `ec_visits` (
  `id` int NOT NULL,
  `vid` int NOT NULL,
  `ts` int NOT NULL,
  `data` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

-- --------------------------------------------------------

--
-- Table structure for table `tags`
--

CREATE TABLE `tags` (
  `id` int NOT NULL,
  `page` int NOT NULL DEFAULT '0',
  `tag` varchar(40) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `tags`
--

INSERT INTO `tags` (`id`, `page`, `tag`) VALUES
(2, 4, ''),
(3, 9, '');

-- --------------------------------------------------------

--
-- Table structure for table `words`
--

CREATE TABLE `words` (
  `id` int NOT NULL,
  `page` int NOT NULL DEFAULT '0',
  `word` varchar(40) NOT NULL DEFAULT ''
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3;

--
-- Dumping data for table `words`
--

INSERT INTO `words` (`id`, `page`, `word`) VALUES
(6, 2, 'right-hand'),
(7, 2, 'sidebar'),
(8, 1, 'left-hand'),
(9, 1, 'sidebar'),
(10, 3, 'welcome'),
(11, 3, 'normanton'),
(12, 3, 'website'),
(13, 3, 'featuring'),
(14, 3, 'people'),
(15, 4, 'faith'),
(16, 4, 'groups'),
(17, 3, 'life'),
(18, 3, 'this'),
(19, 3, 'features'),
(20, 3, 'events'),
(21, 3, 'taking'),
(22, 3, 'place'),
(23, 3, 'around'),
(24, 3, 'town'),
(25, 3, 'full'),
(26, 3, 'interesting'),
(27, 3, 'with'),
(28, 3, 'stories'),
(29, 3, 'where'),
(30, 3, 'tell'),
(31, 3, 'want'),
(32, 3, 'hear'),
(33, 3, 'from'),
(34, 3, 'others'),
(35, 3, 'your'),
(36, 3, 'story'),
(37, 3, 'maybe'),
(38, 3, 'belong'),
(39, 3, 'local'),
(40, 3, 'sporting'),
(41, 3, 'team'),
(42, 3, 'faith'),
(43, 3, 'group'),
(44, 3, 'would'),
(45, 3, 'like'),
(46, 3, 'about'),
(47, 3, 'history'),
(48, 3, 'what'),
(49, 3, 'doing'),
(50, 3, 'now'),
(51, 3, 'business'),
(52, 3, 'give'),
(53, 3, 'insight'),
(54, 3, 'into'),
(55, 3, 'some'),
(56, 3, 'experiences'),
(57, 3, 'pass'),
(58, 3, 'gardening'),
(59, 3, 'money-saving'),
(60, 3, 'tips'),
(61, 3, 'send'),
(62, 3, 'email'),
(63, 3, 'address'),
(64, 3, 'giving'),
(65, 3, 'notes'),
(66, 1, 'website'),
(67, 1, 'features'),
(68, 1, 'people'),
(69, 1, 'normanton'),
(70, 1, 'activities'),
(71, 1, 'events'),
(72, 1, 'taking'),
(73, 1, 'place'),
(74, 1, 'around'),
(75, 9, 'litter'),
(76, 8, 'sport'),
(77, 8, 'normanton'),
(78, 3, 'talk'),
(79, 9, 'picking'),
(80, 9, 'join'),
(81, 9, 'litter-picking'),
(82, 10, 'technical'),
(83, 10, 'information'),
(84, 10, 'about'),
(85, 10, 'this'),
(86, 10, 'website'),
(87, 10, 'been'),
(88, 10, 'designed'),
(89, 10, 'primarily'),
(90, 10, 'ease'),
(91, 10, 'maintenance'),
(92, 10, 'without'),
(93, 10, 'need'),
(94, 10, 'professional'),
(95, 10, 'programming'),
(96, 10, 'almost'),
(97, 10, 'entirely'),
(98, 10, 'coded'),
(99, 10, 'scripts'),
(100, 10, 'running'),
(101, 10, 'browser'),
(102, 10, 'server'),
(103, 10, 'comprises'),
(104, 10, 'couple'),
(105, 10, 'fairly'),
(106, 10, 'easy'),
(107, 10, 'that'),
(108, 10, 'provide'),
(109, 10, 'access'),
(110, 10, 'files'),
(111, 10, 'just'),
(112, 11, 'easycoder'),
(113, 11, 'english-like'),
(114, 11, 'programming'),
(115, 11, 'language'),
(116, 11, 'written'),
(117, 11, 'javascript'),
(118, 11, 'designed'),
(119, 11, 'make'),
(120, 11, 'website'),
(121, 11, 'starts'),
(122, 11, 'which'),
(123, 11, 'provides'),
(124, 11, 'wealth'),
(125, 11, 'information'),
(126, 11, 'about'),
(127, 11, 'using'),
(128, 11, 'full'),
(129, 11, 'reference'),
(130, 11, 'pages'),
(131, 11, 'well'),
(132, 11, 'online'),
(133, 11, 'tutorial'),
(134, 10, 'single'),
(135, 10, 'html'),
(136, 10, 'which'),
(137, 10, 'calls'),
(138, 10, 'easycoder'),
(139, 10, 'from'),
(140, 10, 'when'),
(141, 10, 'runs'),
(142, 10, 'looks'),
(143, 10, 'element'),
(144, 10, 'with'),
(145, 10, 'whose'),
(146, 10, 'content'),
(147, 10, 'compiles'),
(148, 10, 'script'),
(149, 10, 'bootstrap'),
(150, 10, 'loads'),
(151, 10, 'main'),
(152, 10, 'everything'),
(153, 10, 'done'),
(154, 10, 'turn'),
(155, 10, 'other'),
(156, 10, 'needed'),
(157, 10, 'pages'),
(158, 10, 'used'),
(159, 10, 'compiled'),
(160, 10, 'immediately'),
(161, 10, 'after'),
(162, 10, 'they'),
(163, 10, 'loaded'),
(164, 10, 'takes'),
(165, 10, 'very'),
(166, 10, 'little'),
(167, 10, 'time'),
(168, 10, 'even'),
(169, 10, 'biggest'),
(170, 10, 'will'),
(171, 10, 'compile'),
(172, 10, 'tens'),
(173, 10, 'milliseconds'),
(174, 10, 'most'),
(175, 10, 'some'),
(176, 10, 'kept'),
(177, 10, 'memory'),
(178, 10, 'long'),
(179, 10, 'being'),
(180, 10, 'others'),
(181, 10, 'unloaded'),
(182, 10, 'demand'),
(183, 10, 'amout'),
(184, 10, 'system'),
(185, 10, 'small'),
(186, 10, 'typically'),
(187, 10, 'only'),
(188, 13, 'about'),
(189, 12, 'sport'),
(190, 12, 'normanton'),
(191, 4, 'normanton'),
(192, 12, 'about'),
(193, 4, 'information'),
(194, 4, 'christianity'),
(195, 8, 'about'),
(196, 13, 'this'),
(197, 13, 'website'),
(198, 13, 'where'),
(199, 13, 'anyone'),
(200, 13, 'provide'),
(201, 13, 'information'),
(202, 13, 'people'),
(203, 13, 'live'),
(204, 13, 'work'),
(205, 13, 'events'),
(206, 13, 'other'),
(207, 13, 'items'),
(208, 13, 'interest'),
(209, 13, 'everyone'),
(210, 13, 'just'),
(211, 13, 'specific'),
(212, 13, 'groups'),
(213, 13, 'would'),
(214, 13, 'like'),
(215, 13, 'become'),
(216, 13, 'contributor'),
(217, 13, 'contact'),
(218, 13, 'relevant'),
(219, 13, 'please'),
(220, 13, 'email'),
(221, 13, 'following'),
(222, 13, 'also'),
(223, 13, 'visit'),
(224, 13, 'page'),
(225, 13, 'learn'),
(226, 13, 'from'),
(227, 13, 'elsewhere'),
(228, 13, 'similar'),
(229, 13, 'their'),
(230, 14, 'contributing'),
(231, 14, 'this'),
(232, 14, 'website'),
(233, 14, 'have'),
(234, 14, 'news'),
(235, 14, 'information'),
(236, 14, 'about'),
(237, 14, 'normanton'),
(238, 14, 'that'),
(239, 14, 'like'),
(240, 14, 'included'),
(241, 14, 'please'),
(242, 14, 'contact'),
(243, 14, 'submit'),
(244, 14, 'text'),
(245, 14, 'photographs'),
(246, 14, 'email'),
(247, 14, 'page'),
(248, 14, 'yourself'),
(249, 14, 'easy'),
(250, 14, 'process'),
(251, 14, 'touch'),
(252, 14, 'with'),
(253, 14, 'created'),
(254, 14, 'here'),
(255, 14, 'similar'),
(256, 14, 'principle'),
(257, 14, 'required'),
(258, 14, 'facebook'),
(259, 14, 'there'),
(260, 14, 'additional'),
(261, 14, 'complications'),
(262, 14, 'content'),
(263, 14, 'moderated'),
(264, 14, 'admins'),
(265, 14, 'before'),
(266, 14, 'released'),
(267, 14, 'public'),
(268, 14, 'viewing'),
(269, 14, 'will'),
(270, 14, 'able'),
(271, 14, 'articles'),
(272, 14, 'until'),
(273, 14, 'they'),
(274, 14, 'approved'),
(275, 14, 'nobody'),
(276, 14, 'else'),
(277, 14, 'ensure'),
(278, 14, 'require'),
(279, 14, 'standard'),
(280, 14, 'pattern'),
(281, 14, 'come'),
(282, 14, 'which'),
(283, 14, 'what'),
(284, 14, 'list'),
(285, 14, 'when'),
(286, 14, 'first'),
(287, 14, 'visit'),
(288, 14, 'each'),
(289, 14, 'article'),
(290, 14, 'title'),
(291, 14, 'preferably'),
(292, 14, 'banner'),
(293, 14, 'latter'),
(294, 14, 'must'),
(295, 14, 'dimensions'),
(296, 14, 'those'),
(297, 14, 'used'),
(298, 14, 'other'),
(299, 14, 'either'),
(300, 14, 'itself'),
(301, 14, 'formatted'),
(302, 14, 'discourage'),
(303, 14, 'heavy'),
(304, 14, 'unusual'),
(305, 14, 'fonts'),
(306, 14, 'prefer'),
(307, 14, 'same'),
(308, 14, 'overall'),
(309, 14, 'feel'),
(310, 14, 'free'),
(311, 14, 'many'),
(312, 14, 'photos'),
(313, 14, 'images'),
(314, 14, 'long'),
(315, 14, 'excessively'),
(316, 14, 'limit'),
(317, 14, 'length'),
(318, 14, 'should'),
(319, 14, 'without'),
(320, 14, 'saying'),
(321, 14, 'accept'),
(322, 14, 'offensive'),
(323, 14, 'insulting'),
(324, 14, 'publication'),
(325, 14, 'bring'),
(326, 14, 'best'),
(327, 14, 'some'),
(328, 14, 'cases'),
(329, 14, 'possible'),
(330, 14, 'highlight'),
(331, 14, 'problems'),
(332, 14, 'accompanied'),
(333, 14, 'solutions'),
(334, 14, 'constructive'),
(335, 4, 'represented'),
(336, 4, 'number'),
(337, 4, 'churches'),
(338, 4, 'anglicans'),
(339, 4, 'there'),
(340, 4, 'high'),
(341, 4, 'street'),
(342, 4, 'baptist'),
(343, 4, 'church'),
(344, 4, 'also'),
(345, 4, 'right'),
(346, 4, 'town'),
(347, 4, 'centre'),
(348, 4, 'catholics'),
(349, 4, 'john'),
(350, 4, 'newland'),
(351, 4, 'methodist'),
(352, 4, 'almost'),
(353, 4, 'wakefield'),
(354, 4, 'road'),
(355, 4, 'have'),
(356, 4, 'other'),
(357, 4, 'denominations'),
(358, 4, 'faiths'),
(359, 4, 'will'),
(360, 4, 'delighted'),
(361, 4, 'hear'),
(362, 4, 'from');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `articles`
--
ALTER TABLE `articles`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `SLUG` (`slug`) USING BTREE,
  ADD KEY `SECTION` (`section`),
  ADD KEY `AUTHOR` (`author`);

--
-- Indexes for table `ec_data`
--
ALTER TABLE `ec_data`
  ADD PRIMARY KEY (`id`);

--
-- Indexes for table `ec_html`
--
ALTER TABLE `ec_html`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `ec_scripts`
--
ALTER TABLE `ec_scripts`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `name` (`name`);

--
-- Indexes for table `ec_user`
--
ALTER TABLE `ec_user`
  ADD PRIMARY KEY (`email`),
  ADD KEY `NAME` (`name`) USING BTREE;

--
-- Indexes for table `ec_visitors`
--
ALTER TABLE `ec_visitors`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `ts` (`ts`),
  ADD KEY `ip` (`ip`),
  ADD KEY `agent` (`agent`(255));

--
-- Indexes for table `ec_visits`
--
ALTER TABLE `ec_visits`
  ADD PRIMARY KEY (`id`),
  ADD KEY `vid` (`vid`);

--
-- Indexes for table `tags`
--
ALTER TABLE `tags`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page` (`page`),
  ADD KEY `tag` (`tag`);

--
-- Indexes for table `words`
--
ALTER TABLE `words`
  ADD PRIMARY KEY (`id`),
  ADD KEY `page` (`page`),
  ADD KEY `word` (`word`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `articles`
--
ALTER TABLE `articles`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=15;

--
-- AUTO_INCREMENT for table `ec_data`
--
ALTER TABLE `ec_data`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `ec_html`
--
ALTER TABLE `ec_html`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `ec_scripts`
--
ALTER TABLE `ec_scripts`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=24;

--
-- AUTO_INCREMENT for table `ec_visitors`
--
ALTER TABLE `ec_visitors`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `ec_visits`
--
ALTER TABLE `ec_visits`
  MODIFY `id` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `tags`
--
ALTER TABLE `tags`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=4;

--
-- AUTO_INCREMENT for table `words`
--
ALTER TABLE `words`
  MODIFY `id` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=363;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
