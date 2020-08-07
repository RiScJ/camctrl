#ifndef CAMCTRL_ERROR_HPP
#define CAMCTRL_ERROR_HPP

#include <iostream>

namespace camctrl_err {

enum ERROR_MASK {
	MSK_ERR_LEVEL		= 0xF000,
	MSK_ERR_ORIG		= 0x0FF0,
	MSK_ERR_NAME		= 0x000F
};

enum ErrorLevel {
	EL_EMERG,
	EL_ALERT,
	EL_CRIT,
	EL_ERR,
	EL_WARN,
	EL_NOTICE,
	EL_INFO,
	EL_DEBUG,
	EL_PASS			// For notifying actively-passed tests
};

enum GPIO_ERROR {
	E_PASS				= 0x8000,
	E_MMAP				= 0x7010,
	E_MMAP_PRIV			= 0x4011,
	E_MMAP_FAIL			= 0x3012,
	E_PUD				= 0x7020,
	E_PUD_PUR			= 0x5021,
	E_PUD_PDR			= 0x5022,
	E_PUD_PUD			= 0x5023
};

const std::string red("\033[0;31m");
const std::string green("\033[0;32m");
const std::string yellow("\033[0;33m");
const std::string blue("\033[0;34m");
const std::string magenta("\033[0;35m");
const std::string cyan("\033[0;36m");

const std::string reset("\033[0m");

extern std::string print_errorlevel(GPIO_ERROR err);

}

#endif // CAMCTRL_ERROR_HPP
