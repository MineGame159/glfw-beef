using System;
using System.Interop;
using System.Collections;

namespace GLFW {
	extension Glfw {
		[CRepr]
		public struct VkHandle : this(int handle) {}

		[CLink]
		private static extern c_int glfwVulkanSupported();
		/// Returns whether the Vulkan loader and an ICD have been found.
		public static bool VulkanSupported() => glfwVulkanSupported() == TRUE;

		[CLink]
		private static extern c_char** glfwGetRequiredInstanceExtensions(uint32* count);
		/// Returns the Vulkan instance extensions required by GLFW.
		public static void GetRequiredInstanceExtensions(List<StringView> list) {
			uint32 count = 0;
			c_char** chars = glfwGetRequiredInstanceExtensions(&count);
			for (int i < count) list.Add(.(chars[i]));
		}

		[CLink]
		private static extern void* glfwGetInstanceProcAddress(void* instance, c_char* procname);
		/// Returns the address of the specified Vulkan instance function.
		public static void* GetInstanceProcAddress(void* instance, StringView procname) => glfwGetInstanceProcAddress(instance, procname.ToScopeCStr!());

		[CLink]
		private static extern c_int glfwGetPhysicalDevicePresentationSupport(void* instance, void* ddvice, uint32 queueFamily);
		/// Returns whether the specified queue family can present images.
		public static bool GetPhysicalDevicePresentationSupport(void* instance, void* device, uint32 queueFamily) => glfwGetPhysicalDevicePresentationSupport(instance, device, queueFamily) == TRUE;

		[LinkName("glfwCreateWindowSurface")]
		/// Creates a Vulkan surface for the specified window.
		public static extern int32 CreateWindowSurface(VkHandle instance, GlfwWindow* window, void* allocator, void* surface);
	}
}
