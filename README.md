# Compilers
<a href="https://www.buymeacoffee.com/xagentx"><img src="https://img.buymeacoffee.com/button-api/?text=Buy me a coffee&emoji=&slug=xagentx&button_colour=FFDD00&font_colour=000000&font_family=Cookie&outline_colour=000000&coffee_colour=ffffff" /></a>

## About
This is a fork of [Judge0/compilers](https://github.com/judge0/compilers). It is used for [Agent-01/Judge0], a fork of [Judge0](https://github.com/judge0/judge0).

## Get Started
1. Build the compilers image
2. Build the [Agent-01/Judge0] image using this image
3. Edit the docker-compose file from [Judge0](https://github.com/judge0/judge0) and change the image to what you just built
4. Edit judge0.conf and put it in the same directory
5. Run docker compose up -d

## Debugging
1. Refer to this issue for building commands https://github.com/judge0/judge0/issues/250
2. Check if websites in docker file is down
3. Check container logs

## Supported Languages

### Judge0
<details><summary>Click here to expand the list</summary>
<table>
<thead>
<tr>
<th style="text-align:center">#</th>
<th style="text-align:center">Name</th>
</tr>
</thead>
<tbody>
<tr>
<td style="text-align:center">1</td>
<td style="text-align:center">Assembly (NASM 2.14.02)</td>
</tr>
<tr>
<td style="text-align:center">2</td>
<td style="text-align:center">Brainfuck (5.0.0)</td>
</tr>
<tr>
<td style="text-align:center">3</td>
<td style="text-align:center">C (GCC 9.2.0)</td>
</tr>
<tr>
<td style="text-align:center">4</td>
<td style="text-align:center">C (GCC 12.3.0)</td>
</tr>
<tr>
<td style="text-align:center">5</td>
<td style="text-align:center">C# (Mono 6.12.0.206)</td>
</tr>
<tr>
<td style="text-align:center">6</td>
<td style="text-align:center">C++ 17 (GCC 9.2.0)</td>
</tr>
<tr>
<td style="text-align:center">7</td>
<td style="text-align:center">C++ 17 (GCC 12.3.0)</td>
</tr>
<tr>
<td style="text-align:center">8</td>
<td style="text-align:center">C++ 20 (GCC 12.3.0)</td>
</tr>
<tr>
<td style="text-align:center">9</td>
<td style="text-align:center">Go (1.22.2)</td>
</tr>
<tr>
<td style="text-align:center">10</td>
<td style="text-align:center">Haskell (GHC 8.8.4)</td>
</tr>
<tr>
<td style="text-align:center">11</td>
<td style="text-align:center">Java (OpenJDK 22.0.1)</td>
</tr>
<tr>
<td style="text-align:center">12</td>
<td style="text-align:center">JavaScript (Node.js 12.14.0)</td>
</tr>
<tr>
<td style="text-align:center">13</td>
<td style="text-align:center">Lua (5.4.6)</td>
</tr>
<tr>
<td style="text-align:center">14</td>
<td style="text-align:center">Pascal (FPC 3.2.2)</td>
</tr>
<tr>
<td style="text-align:center">15</td>
<td style="text-align:center">PHP (8.3.6)</td>
</tr>
<tr>
<td style="text-align:center">16</td>
<td style="text-align:center">Plain Text</td>
</tr>
<tr>
<td style="text-align:center">17</td>
<td style="text-align:center">Python (3.11.8)</td>
</tr>
<tr>
<td style="text-align:center">18</td>
<td style="text-align:center">Pypy (3.10)</td>
</tr>
<tr>
<td style="text-align:center">19</td>
<td style="text-align:center">R (4.4.0)</td>
</tr>
<tr>
<td style="text-align:center">20</td>
<td style="text-align:center">Ruby (3.3.1)</td>
</tr>
<tr>
<td style="text-align:center">21</td>
<td style="text-align:center">Rust (1.77.2)</td>
</tr>
<tr>
<td style="text-align:center">22</td>
<td style="text-align:center">SQL (SQLite 3.27.2)</td>
</tr>
</tbody>
</table>
</details>
