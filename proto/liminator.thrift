namespace java dev.vality.liminator
namespace erlang liminator.liminator

typedef i64 LimitId

/* Наименование лимита (например, limit.card.day.777) */
typedef string LimitName

/* ИД операции изменения значения (например, invoice.1) */
typedef string OperationId

typedef map<string, string> Context

typedef i64 Value

/* Временная метка операции epochmills */
typedef i64 Timestamp

exception LimitNotFound {}
exception DuplicateLimitName {}

struct CreateLimitRequest {
    1: required LimitName limit_name
    2: optional Context context
}

struct LimitRequest {
    1: required LimitName limit_name
    2: required OperationId operation_id
    3: required Value value
}

struct LimitResponse {
    1: required LimitName limit_name
    2: required Value commit_value
    3: required Value hold_value
}

service LiminatorService {

    /* Создать счетчик для дальнейшего подсчета */
    LimitResponse Create(CreateLimitRequest request) throws (1: DuplicateLimitName ex1)

    /* Добавить значение */
    list<LimitResponse> Hold(list<LimitRequest> request) throws (1: LimitNotFound ex1)

    /* Применить значение */
    list<LimitResponse> Commit(list<LimitRequest> request) throws (1: LimitNotFound ex1)

    /* Отменить добавление */
    bool Rollback(list<LimitRequest> request) throws (1: LimitNotFound ex1)

    /* Получить значение */
    list<LimitResponse> Get(list<LimitName> limit_names) throws (1: LimitNotFound ex1)
}