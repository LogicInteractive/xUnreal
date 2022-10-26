package lib.utils;
import lib.types.Rectangle;

typedef Slice9Rects = {
    src:Array<Rectangle>,
    dst:Array<Rectangle>
}

class Slice9 {
    public static function buildRects(w:Float, h:Float, bitmapWidth:Float, bitmapHeight:Float, slice:Rectangle):Slice9Rects {
        var srcRects:Array<Rectangle> = buildSrcRects(bitmapWidth, bitmapHeight, slice);
        var dstRects:Array<Rectangle> = buildDstRects(w, h, srcRects);
        return {
            src: srcRects,
            dst: dstRects
        }
    }

    public static function buildSrcRects(bitmapWidth:Float, bitmapHeight:Float, slice:Rectangle):Array<Rectangle> {
        var x1:Float = slice.left;
        var y1:Float = slice.top;
        var x2:Float = slice.width;
        var y2:Float = slice.height;

        var srcRects:Array<Rectangle> = [];
        srcRects.push(new Rectangle(0, 0, x1, y1)); // top left
        srcRects.push(new Rectangle(x1, 0, (x2 + x1), y1)); // top middle
        srcRects.push(new Rectangle(bitmapWidth - x2, 0, x2, y1)); // top right

        srcRects.push(new Rectangle(0, y1, x1, bitmapHeight-(y2+y1))); // left middle
        srcRects.push(new Rectangle(x1, y1, x2 + x1, bitmapHeight-(y2+y1))); // middle
        srcRects.push(new Rectangle(bitmapWidth - x2, y1, x2, bitmapHeight-(y2+y1))); // top right

        srcRects.push(new Rectangle(0, bitmapHeight - y2, x1, y2)); // bottom left
        srcRects.push(new Rectangle(x1, bitmapHeight - y2, (x2 + x1), y2)); // bottom middle
        srcRects.push(new Rectangle(bitmapWidth - x2, bitmapHeight - y2, x2, y2)); // bottom middle

        return srcRects;
    }

    public static function buildDstRects(w:Float, h:Float, srcRects:Array<Rectangle>):Array<Rectangle> {
        var dstRects:Array<Rectangle> = [];

        dstRects.push(srcRects[0]);
        dstRects.push(new Rectangle(srcRects[1].x, srcRects[1].y, w - srcRects[1].width, srcRects[1].height));
        dstRects.push(new Rectangle(w - srcRects[2].width, srcRects[1].y, srcRects[2].width, srcRects[2].height));

        dstRects.push(new Rectangle(srcRects[3].x, srcRects[3].y, srcRects[3].width, h-(srcRects[6].height+srcRects[1].height)));
        dstRects.push(new Rectangle(srcRects[4].x, srcRects[4].y, w - srcRects[4].width, h-(srcRects[6].height+srcRects[1].height)));
        dstRects.push(new Rectangle(w-srcRects[5].width, srcRects[5].y, srcRects[5].width, h-(srcRects[6].height+srcRects[1].height)));

		dstRects.push(new Rectangle(0, h - srcRects[6].height, srcRects[6].width, srcRects[6].height));
		dstRects.push(new Rectangle(srcRects[7].x, h - srcRects[7].height, w-srcRects[7].width, srcRects[7].height));
        dstRects.push(new Rectangle(w - srcRects[8].width, h - srcRects[8].height, srcRects[8].width, srcRects[8].height));

        return dstRects;
    }
}