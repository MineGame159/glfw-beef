# Glfw-Beef
**glfw-beef** is a Beef wrapper library for **GLFW 3.0.2**. Contains everything that except native access. Functions that return cstring are converted to return void and take String as a buffer to what the actuall return value will be appended.

**Note:** When passing delegates to callbacks you must allocate them on heap and not on stack.

# Quick Start *(using Beef IDE)*
1. **Download** glfw-beef and copy it into your beef folder and into BeefLibs.
2. Right-click on your workspace and select **Add from Installed** and choose glfw-beef.
3. **Make** glfw-beef **as a dependency** of your project.
4. Enjoy beautiful **GLFW**.

This does not come with any graphics api. But you can check out my [opengl-beef](https://github.com/MineGame159/opengl-beef) library.

## Linux usage

To use this library on linux, install **libglfw3-dev** package and add **-lglfw** to link flags. For example, in your BeefProj.toml add

```
[Configs.Debug.Linux64]
OtherLinkFlags = "$(LinkFlags) -lglfw"

[Configs.Release.Linux64]
OtherLinkFlags = "$(LinkFlags) -lglfw"
```
