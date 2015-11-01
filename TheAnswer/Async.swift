import Foundation

func async(block: (() -> Void)) {
    let queue = dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)
    dispatch_async(queue, block)
}

func sync_main(block: (() -> Void)) {
    let queue = dispatch_get_main_queue()
    dispatch_sync(queue, block)
}
