# Glfw-Beef
**glfw-beef** is a Beef wrapper library for **GLFW 3.3.4**. Functions that return cstring are converted to return void and take String as a buffer to what the actuall return value will be appended.

You can find an example in the [example](https://github.com/MineGame159/glfw-beef/tree/master/example) folder.

**Note:** When passing delegates to callbacks you must allocate them on heap and not on stack.
**Note:** Native access is only partially implemented.

# Quick Start *(using Beef IDE)*
1. **Download** glfw-beef and copy it into your beef folder and into BeefLibs.
2. Right-click on your workspace and select **Add from Installed** and choose GLFW.
3. **Make** GLFW **as a dependency** of your project.
4. Enjoy beautiful **GLFW**.

This does not come with any graphics api. But you can check out my [opengl-beef](https://github.com/MineGame159/opengl-beef) library.

## Linux usage

To use this library on Linux you must install **libglfw3-dev** package.