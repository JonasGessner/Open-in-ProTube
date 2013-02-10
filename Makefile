ARCHS = armv7 armv7s
TARGET_IPHONEOS_DEPLOYMENT_VERSION = 5.0
TARGET_CC = xcrun -sdk iphoneos clang 
TARGET_CXX = xcrun -sdk iphoneos clang++
TARGET_LD = xcrun -sdk iphoneos clang++
SHARED_CFLAGS = -fobjc-arc

include theos/makefiles/common.mk

TWEAK_NAME = OpeninProTube
OpeninProTube_FILES = Tweak.xm
OpeninProTube_FRAMEWORKS = Foundation UIKit

include $(THEOS_MAKE_PATH)/tweak.mk
