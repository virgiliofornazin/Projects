#define CPP_COMPATIBILITY_NAMESPACE                                             cpp_compatibility

#include <cpp_compatibility/std/mutex>
#include <cpp_compatibility/std/memory>

/*
#include <cpp_compatibility/latest_features.hpp>

#include <boost/chrono.hpp>
#include <boost/type_traits.hpp>


namespace CPP_COMPATIBILITY_NAMESPACE
{
    template <class Lockable>
    class shared_lock
        : public boost::shared_lock<Lockable>
    {
    private:
        typedef boost::shared_lock<Lockable> base_type;

    public:
        shared_lock() noexcept = default;

#if (CPP_COMPATIBILITY_DIALECT >= CPP_COMPATIBILITY_DIALECT_0X)
        shared_lock(shared_lock&&) noexcept = default;

        shared_lock& operator = (shared_lock&&) noexcept = default;
#endif // (CPP_COMPATIBILITY_DIALECT >= CPP_COMPATIBILITY_DIALECT_0X)

        explicit shared_lock(Lockable& lockable)
            : base_type(lockable)
        {
        }

        explicit shared_lock(Lockable& lockable, adopt_lock_t) noexcept
            : base_type(lockable, boost::adopt_lock)
        {
        }

        explicit shared_lock(Lockable& lockable, defer_lock_t) noexcept
            : base_type(lockable, boost::defer_lock)
        {
        }

        explicit shared_lock(Lockable& lockable, try_to_lock_t)
            : base_type(lockable, boost::try_to_lock)
        {
        }

        template <class Rep, class Period>
        explicit shared_lock(Lockable& lockable, std::chrono::duration<Rep, Period> const& timeout_duration)
            : base_type(lockable, boost::defer_lock)
        {
            try_lock_for(timeout_duration);
        }

        template <class Clock, class Duration>
        explicit shared_lock(Lockable& lockable, std::chrono::time_point<Clock, Duration> const& timeout_time)
            : base_type(lockable, boost::defer_lock)
        {
            try_lock_until(timeout_time);
        }

        template <class Rep, class Period>
        bool try_lock_for(std::chrono::duration<Rep, Period> const& timeout_duration)
        {
            return base_type::try_lock_for(detail::duration_from_std(timeout_duration));
        }

        template <class Clock, class Duration>
        bool try_lock_until(std::chrono::time_point<Clock, Duration> const& timeout_time)
        {
            return base_type::try_lock_until(detail::time_point_from_std(timeout_time));
        }
    };
}
*/
template <typename Int>
static inline Int zero() { return 0; }

namespace foo
{
    using ::zero;
}

int main(int /* argc */, char** /* argv */)
{
    return foo::zero<int>();
/*
    cpp_compatibility::shared_mutex s;
    s.lock();
    cpp_compatibility::shared_lock<cpp_compatibility::shared_mutex> sl(s, std::chrono::system_clock::now() + std::chrono::seconds(2));

    return 0;
    */
}
