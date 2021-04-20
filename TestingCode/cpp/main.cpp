#define CPP_COMPATIBILITY_NAMESPACE                                             cpp_compatibility

#include <cpp_compatibility/latest_features.hpp>

#include <boost/chrono.hpp>

namespace CPP_COMPATIBILITY_NAMESPACE
{
    namespace chrono = boost::chrono;

    namespace detail
    {
        template <class Rep, class Period>
        static constexpr inline boost::chrono::duration<Rep, Period> duration_from_std(std::chrono::duration<Rep, Period> const& duration)
        {
            return boost::chrono::duration<Rep, Period>(duration.count());
        }

        template <class Clock, class Duration>
        static constexpr inline boost::chrono::time_point<Clock, Duration> timepoint_from_std(std::chrono::time_point<Clock, Duration> const& timepoint)
        {
            return boost::chrono::time_point<Clock, Duration>(boost::chrono::duration_cast<Duration>(timepoint.time_since_epoch()));
        }
    }
}

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
            return try_lock_for(detail::duration_from_std(timeout_duration));
        }

        template <class Clock, class Duration>
        bool try_lock_until(std::chrono::time_point<Clock, Duration> const& timeout_time)
        {
            return try_lock_until(detail::timepoint_from_std(timeout_time));
        }
    };
}

int main(int /* argc */, char** /* argv */)
{
    std::shared_mutex s;
    cpp_compatibility::shared_lock<std::shared_mutex> sl(s);

    return 0;
}
