#ifndef DEBUG_H
#define DEBUG_H

//#include <iostream>
//#include <vector>
//#include <tuple>
//#include <type_traits>
//#include <chrono>
//#include <utility>
//#include <set>
//#include <map>
//#include <deque>
//#include <list>
//#include <string>
//#include <iterator>

#include <boost/pfr.hpp>
// Inline namespace for IO operations
inline namespace IODEB {
#define SFINAE(x, ...)                                                         \
    template <class, class = void> struct x : std::false_type {};              \
    template <class T> struct x<T, std::void_t<__VA_ARGS__>> : std::true_type {}

SFINAE(DefaultI, decltype(std::cin >> std::declval<T &>()));
SFINAE(DefaultO, decltype(std::cout << std::declval<T &>()));
SFINAE(IsTuple, typename std::tuple_size<T>::type);
SFINAE(Iterable, decltype(std::begin(std::declval<T>())));


template <auto &os, bool debug, bool print_nd> struct Writer {
    std::string comma() const { return debug ? "," : ""; }
    template <class T> constexpr char Space(const T &) const {
        return print_nd && (Iterable<T>::value or IsTuple<T>::value) ? '\n'
                                                                     : ' ';
    }
    template <class T> void Impl(T const &t) const {
        if constexpr (DefaultO<T>::value) os << t;
        else if constexpr (Iterable<T>::value) {
            if (debug) os << '[';
            int i = 0;
            for (auto &&x : t)
                ((i++) ? (os << comma() << Space(x), Impl(x)) : Impl(x));
            if (debug) os << ']';
        } else if constexpr (IsTuple<T>::value) {
            if (debug) os << '(';
            std::apply(
                [this](auto const &...args) {
                    int i = 0;
                    (((i++) ? (os << comma() << " ", Impl(args)) : Impl(args)),
                     ...);
                },
                t);
            if (debug) os << ')';
        } else static_assert(IsTuple<T>::value, "No matching type for print");
    }
    template <class T> void ImplWrapper(T const &t) const {
        if (debug) os << "\033[0;33m"; //31 rojo 
        Impl(t);
        if (debug) os << "\033[0m";
    }
    template <class... Ts> void print(Ts const &...ts) const {
        ((Impl(ts)), ...);
    }
    template <class F, class... Ts>
    void print_with_sep(const std::string &sep, F const &f,
                        Ts const &...ts) const {
        ImplWrapper(f), ((os << sep, ImplWrapper(ts)), ...), os << '\n';
    }
    void print_with_sep(const std::string &) const { os << '\n'; }
};

template <class... Ts> void pr(Ts const &...ts) {
    Writer<std::cout, false, true>{}.print(ts...);
}
template <class... Ts> void ps(Ts const &...ts) {
    Writer<std::cout, false, true>{}.print_with_sep(" ", ts...);
}

} // namespace IO

// Inline namespace for debugging operations
inline namespace Debug {
template <typename... Args> void err(Args... args) {
    Writer<std::cerr, true, false>{}.print_with_sep(" | ", args...);
}
template <typename... Args> void errn(Args... args) {
    Writer<std::cerr, true, true>{}.print_with_sep(" | ", args...);
}

void err_prefix(std::string func, int line, std::string args) {
    std::cerr << "\033[0;31m\u001b[1mDEBUG\033[0m"
              << " | "
              << "\u001b[34m" << func << "\033[0m"
              << ":"
              << "\u001b[34m" << line << "\033[0m"
              << " - "
              << "[" << args << "] = ";
}
const auto beg_time = std::chrono::high_resolution_clock::now();
// https://stackoverflow.com/questions/47980498/accurate-c-c-clock-on-a-multi-core-processor-with-auto-overclock?noredirect=1&lq=1
double time_elapsed() {
	return std::chrono::duration<double>(std::chrono::high_resolution_clock::now() -
	                                beg_time)
	    .count();
}

template<typename T>
inline void debul(const std::vector<T>& v, int n, const std::string& name, const std::string& func, int line) {
    std::cerr <<"\033[0;31m"<<"DEBUG "<< "\033[0;32m" << func << "\033[0m " // Green color for function
              << "\033[0;32m" << line << "\033[0m " // Green color for line
              << "[" << "\033[0;33m" << name << "\033[0m" << "]" // Yellow color for variable name
              << " | ";
    for (int i = 0; i < n; i++)
        std::cerr <<"\033[0;33m"<< v[i] << " \n"[i == n - 1];
}

template<typename T>
inline void debul(const T* v, int n, const std::string& name, const std::string& func, int line) {
    std::cerr <<"\033[0;31m"<<"DEBUG "<< "\033[0;32m" << func << "\033[0m " // Green color for function
              << "\033[0;32m" << line << "\033[0m " // Green color for line
              << "[" << "\033[0;33m" << name << "\033[0m" << "]" // Yellow color for variable name
              << " | ";
    for (int i = 0; i < n; i++)
        std::cerr <<"\033[0;33m"<< v[i] << " \n"[i == n - 1];
}


// Función para imprimir automáticamente los miembros de cualquier struct
template <typename T>
void printStruct(const T& s) {
    boost::pfr::for_each_field(s, [](const auto& field) {
        std::cerr << field << " ";
    });
    std::cerr << '\n';
}
template<class Node>
void f(std::vector<Node>& v) {
    for (const auto& n : v) {
        printStruct(n);
    }
}
// Nueva versión de debs para imprimir estructuras automáticamente

template <typename T>
inline void debs_impl(const T v, const std::string& name, const std::string& func, int line) {
    std::cerr <<"\033[0;31m"<<"DEBUG "<< "\033[0;32m" << func << "\033[0m " // Green color for function
              << "\033[0;32m" << line << "\033[0m " // Green color for line
              << "[" << "\033[0;33m" << name << "\033[0m" << "]" // Yellow color for variable name
              << " |\n";
    for (const auto& n : v) {
        printStruct(n);
    }
    std::cerr<<"============================ fin V<node> ========================="<<'\n';

}

#define deb(args...) err_prefix(__FUNCTION__, __LINE__, #args), err(args)
#define debs(args...) debs_impl(args, #args, __FUNCTION__, __LINE__)
#define debl(v,n,...) debul(v,n,#v,__FUNCTION__,__LINE__)
#define time_elapsed_prefix() std::cerr << "             \033[0;32m\u001b[1mTIME\033[0m" \
                                        << " | " 
#define TIME time_elapsed_prefix(), std::cerr << time_elapsed() << " s" << '\n';
#define CASE(t) std::cerr<<"------------------ CASE: "<<t+1<<" ---------------------------"<<'\n';
#define LINE    std::cerr<<"--------------------------------------------------------"<<'\n';
#define XD std::cerr<<"\t\tTRY AGAIN... TRY BETTER!"<<'\n';

} // namespace Debug
#endif // DEBUG_H



