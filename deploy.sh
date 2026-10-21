#!/bin/sh
# 发布到 GitHub Pages：index.html 是给 Claude Artifact 用的片段（外壳由 Claude 补），这里补上同样的外壳
set -e
cd "$(dirname "$0")"
mkdir -p docs
{
  printf '<!doctype html>\n<html lang="zh-CN">\n<head>\n<meta charset="utf-8">\n<meta name="viewport" content="width=device-width, initial-scale=1, viewport-fit=cover">\n'
  printf '<style>:root{padding-top:env(safe-area-inset-top,0px);padding-bottom:env(safe-area-inset-bottom,0px)}body{margin:0}img{max-width:100%%}[hidden]{display:none!important}</style>\n</head>\n<body>\n'
  cat index.html
  printf '\n</body>\n</html>\n'
} > docs/index.html
git add index.html deploy.sh docs/index.html
git commit -q -m "${1:-更新食谱}" || { echo "没有改动"; exit 0; }
git push -q
echo "已推送，约 1 分钟后生效：https://starry-x.github.io/meal-plan/"
