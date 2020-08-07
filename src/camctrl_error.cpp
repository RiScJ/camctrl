#include "camctrl_error.hpp"

namespace camctrl_err {

std::string print_errorlevel(GPIO_ERROR err) {
	unsigned short el = err;
	el &= MSK_ERR_LEVEL;
	el >>= 12;
	switch (el) {
	case EL_EMERG: {
		return "[ EMERG   ]";
		break;
	}
	case EL_ALERT: {
		return "[ ALERT   ]";
		break;
	}
	case EL_CRIT: {
		return "[ CRIT    ]";
		break;
	}
	case EL_ERR: {
		return "[ " + red + "ERROR" + reset + "   ]";
		break;
	}
	case EL_WARN: {
		return "[ " + yellow + "WARNING" + reset + " ]";
		break;
	}
	case EL_NOTICE: {
		return "[ " + cyan + "NOTICE" + reset + "  ]";
		break;
	}
	case EL_INFO: {
		return "[ INFO    ]";
		break;
	}
	case EL_DEBUG: {
		return "[ DEBUG   ]";
		break;
	}
	case EL_PASS: {
		return "[ " + green + "PASS" + reset + "    ]";
		break;
	}
	default: {
		return "";
		break;
	}
	}
};

}

